//
//  UIStoryboard+Extension.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation
import UIKit

enum AppStoryboards: String {
    case Common
    case MediaLibrary
}

enum StoryboardsViewControllerIdentifiers: String  {
    case appInfoAlertVC = "appInfoAlertVC"
    
    // Media Library
    case MediaProgramTracksVC
    case MediaLibraryProgramsVC
}

extension UIStoryboard {
    
    static func getViewController(inStoryboard storyboard: AppStoryboards, identifier: StoryboardsViewControllerIdentifiers) -> UIViewController {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier.rawValue)
    }
}
