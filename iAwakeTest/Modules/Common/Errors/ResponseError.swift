//
//  ResponseError.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation

enum ResponseError: Error {
    case invalidData
    case emptyData
    case contactAdmin
    case requestFailed
}

extension ResponseError:CustomStringConvertible {
    var description: String{
        switch self {
        case .invalidData:
            return "Data is invalid"
        case .emptyData:
            return "Null response data"
        case .contactAdmin:
            return "Contact administrator"
        case .requestFailed:
            return "Your request has failed."
        }
    }
}

enum CommonError: Error {
    case emptyData
    case invalidUser
    case invalidDataFormat
    case errorSavingToLocal
    case invalidSessionCart
}

extension CommonError:CustomStringConvertible {
    var description: String{
        switch self {
        case .invalidUser:
            return "User is invalid"
        case .invalidDataFormat:
            return "Could not process your request. Please contact app admin."
        case .emptyData:
            return "Empty data returned"
        case .errorSavingToLocal:
            return "Could not save session user"
        case .invalidSessionCart:
            return "Cart is not valid."
        }
    }
}

enum HTTPError: Error {
    case unknownError
    case notAuthorized
    case notFound
    case timeout
}

extension HTTPError:CustomStringConvertible {
    var description: String{
        switch self {
        case .notFound:
            return "Not found"
        case .notAuthorized:
            return "Not authorized"
        case .timeout:
            return "Request timeout"
        default:
            return "An error occurred"
        }
    }
}

enum AlamofireErrorCodes: Int {
    case canceled = -999
}
