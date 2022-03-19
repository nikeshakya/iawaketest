//
//  AppStrings.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation

struct AppStrings {
    
    struct Info {
        static var success: String {
            return "Success"
        }
    }
    
    struct Errors {
        static var errorTitle: String {
            return "Error"
        }
        static var warningTitle: String {
            return "Warning"
        }
        static var couldNotCompleteRequest: String {
            return "Could not complete your request."
        }
    }
    static var ok: String {
        return "Ok"
    }
    static var cancel: String {
        return "Cancel"
    }
    static var appName: String {
        return "iAwakeTest"
    }
    static var alert: String {
        return "Alert"
    }
    static var yes: String {
        return "Yes"
    }
    static var no: String {
        return "No"
    }
}
