//
//  NetworkRequestManager.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

typealias responseBlock = (_ result:Any?, _ error: Error?) -> ()

enum ParameterContentType: String {
    case formURLEncoded = "application/x-www-form-urlencoded"
    case plainText = "text/plain"
    case multipartForm = "multipart/form-data"
    case json = "application/json"
    case none = ""
    case all = "*/*"
}

struct EmptySuccessResponse {
}

class NetworkRequestManager {
    static let shared = NetworkRequestManager(session: .default)
    
    var sessionManager: Session!
    
    init(session: Session) {
        self.sessionManager = session
    }
    
    static func getNewSession() -> Session {
        let configuration = URLSessionConfiguration.default
        return Alamofire.Session(configuration: configuration)
    }
    
    func getHeader(authorized: Bool = false, contentType: ParameterContentType = .none, accept: ParameterContentType = .all) -> [String : String] {
        var headers: [String : String] = [:]
        headers =  [
            "Content-Type": contentType.rawValue,
            "Accept": accept.rawValue
        ]
        if contentType == .multipartForm || contentType == .none{
            headers.removeValue(forKey: "Content-Type")
        }
        return headers
    }
    
    private func getPostString(params:[String:Any]) -> String {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    private func convertErrorResponseToLocalError(data: Data) -> GenericError? {
        let decoder = JSONDecoder()
        do {
            let error = try decoder.decode(String.self, from: data)
            return GenericError(title: nil, description: error, code: 4022)
        } catch {
            return nil
        }
    }
    
    func invalidateAllSessionRequests(completion: @escaping responseBlock) {
        sessionManager.session.getTasksWithCompletionHandler { (datatsk, uploadtsk, dwnloadtsk) in
            datatsk.forEach({$0.cancel()})
            uploadtsk.forEach({$0.cancel()})
            dwnloadtsk.forEach({$0.cancel()})
            completion(true, nil)
        }
    }
    
    func processApiRequest<T: Decodable>(urlLink: String, returnType: T.Type = T.self, parameters: Parameters, method: HTTPMethod,  headers: [String: String], parameterDestination: URLEncoding.Destination? = nil, isContentJSON: Bool = false, isContentArrayJSON: Bool = false, isContentJSONString: Bool = false, completion: @escaping responseBlock) {
        let destination: URLEncoding.Destination = parameterDestination ?? .methodDependent
        var ApiRequest = self.sessionManager.request(urlLink, method: method, parameters: parameters, encoding: URLEncoding(destination: destination) , headers: HTTPHeaders(headers))
        if isContentJSON {
            ApiRequest = self.sessionManager.request(urlLink, method: method, parameters: parameters, encoding: JSONEncoding.default , headers:  HTTPHeaders(headers))
        }
        else if isContentArrayJSON {
            ApiRequest = self.sessionManager.request(urlLink, method: method, parameters: parameters, encoding: ArrayJSONEncoding(options: .prettyPrinted) , headers:  HTTPHeaders(headers))
        }
        else if isContentJSONString {
            let stringEncoding = parameters.first?.value as? String ?? ""
            ApiRequest = self.sessionManager.request(urlLink, method: method, parameters: [:], encoding: stringEncoding , headers:  HTTPHeaders(headers))
        }
        ApiRequest.validate().responseDecodable(of: returnType.self) { (response) in
            switch response.result {
            case .success(let data):
                completion(response.data ?? data, nil)
                break
            case .failure(let error):
                debugPrint("-------API RESPONSE ERROR-------\nError in url (\(response.request?.url?.absoluteString ?? "nA")\n response: \(error.localizedDescription))")
                if response.response?.statusCode == 200 {
                    debugPrint("Status Code 200 is Accepted so bypassing response...")
                    if let object = response.value {
                        completion(object, nil)
                    }
                    else if let data = response.data, data.count > 0 {
                        completion(data, nil)
                    }
                    else {
                        completion(EmptySuccessResponse(), nil)
                    }
                    return
                }
                if response.response?.statusCode == 204 {
                    debugPrint("Status Code 204 is Accepted so bypassing response...")
                    if let data = response.data, data.count > 0 {
                        completion(data, nil)
                    }
                    else {
                        completion(EmptySuccessResponse(), nil)
                    }
                    return
                }
                if response.response?.statusCode == NSURLErrorTimedOut {
                    completion(nil, HTTPError.timeout)
                    return
                }
                if response.response?.statusCode == 400, let respData = response.data {
                    if let jsonError = self.convertErrorResponseToLocalError(data: respData) {
                        completion(nil, jsonError)
                        break
                    }
                    else {
                        completion(nil, error)
                        break
                    }
                }
                if let respData = response.data {
                    if let jsonError = self.convertErrorResponseToLocalError(data: respData) {
                        completion(nil, jsonError)
                        break
                    }
                    else {
                        completion(nil, error)
                        break
                    }
                }
                completion(nil, error)
                break
            }
        }
    }
}

let networkRequestArrayParametersKey = "arrayParametersKey"

/// Extenstion that allows an array be sent as a request parameters
extension Array {
    /// Convert the receiver array to a `Parameters` object.
    func asParameters() -> Parameters {
        return [networkRequestArrayParametersKey: self]
    }
}


/// Convert the parameters into a json array, and it is added as the request body.
/// The array must be sent as parameters using its `asParameters` method.
public struct ArrayJSONEncoding: ParameterEncoding {
    
    /// The options for writing the parameters as JSON data.
    public let options: JSONSerialization.WritingOptions
    
    
    /// Creates a new instance of the encoding using the given options
    ///
    /// - parameter options: The options used to encode the json. Default is `[]`
    ///
    /// - returns: The new instance
    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters,
              let array = parameters[networkRequestArrayParametersKey] else {
                  return urlRequest
              }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: options)
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
            
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        
        return urlRequest
    }
}

extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}
