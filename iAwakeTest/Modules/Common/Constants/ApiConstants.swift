//
//  ApiConstants.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation

enum ApiLink: String{
    enum mediaLibrary: String{
        case getFreeLibrary = "/media-library/free"
    }
    case baseDomainDevelopment = "https://api.iawaketechnologies.com/api/v2"
}

enum GetApiAddress {
    case mediaLibrary(ApiLink.mediaLibrary, [String])
    
    var url: String {
        let domainUrl = ApiLink.baseDomainDevelopment.rawValue
        switch self {
        case .mediaLibrary(let ApilinkAddress, let values):
            let postFixAddress = String(format: ApilinkAddress.rawValue, arguments: values)
            return "\(domainUrl)\(postFixAddress)"
        }
    }
    
}
