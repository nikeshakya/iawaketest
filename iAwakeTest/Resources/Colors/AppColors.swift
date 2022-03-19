//
//  AppColors.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import UIKit

enum AppColors: String {
    case appBlack
    case appGreen
    case appLightGray
    case appWhite
    case appRed
    case appLightRed
    case appLightPink
}

extension UIColor {
    
    static var appGreen: UIColor? {
        return UIColor(named: AppColors.appGreen.rawValue)
    }
    
    static var appLightPink: UIColor? {
        return UIColor(named: AppColors.appLightPink.rawValue)
    }
    
    static var appWhite: UIColor? {
        return UIColor(named: AppColors.appWhite.rawValue)
    }
    
    static var appLightRed: UIColor? {
        return UIColor(named: AppColors.appLightRed.rawValue)
    }
    
    static var appLightGray: UIColor? {
        return UIColor(named: AppColors.appLightGray.rawValue)
    }
    
    static var appRed: UIColor? {
        return UIColor(named: AppColors.appRed.rawValue)
    }
    
    static var appBlack: UIColor? {
        return UIColor(named: AppColors.appBlack.rawValue)
    }
}
