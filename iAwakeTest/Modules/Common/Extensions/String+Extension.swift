//
//  String+Extension.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation
import UIKit

extension String {
    
    var isValidUrl: Bool {
        var selfString = self
        if !selfString.contains("http:\\") && !selfString.contains("https:\\"){
            selfString = "http:\\\(selfString)"
        }
        if let url = URL(string: selfString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    
    var isNotUrlLink: Bool {
        if let url = URL(string: self) {
            return !UIApplication.shared.canOpenURL(url as URL)
        }
        return true
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
