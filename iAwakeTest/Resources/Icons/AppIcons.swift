//
//  AppIcons.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation
import UIKit

enum AppIcons: String {
    case successIcon = "success-alert-ic"
    case failureIcon = "failure-alert-ic"
    case defaultImagePlaceholder = "image-placeholder-ic"
    case albumPlaceholder = "music-album-placeholder-ic"
    case audioPlayIcon = "audio-play-ic"
    case audioPauseIcon = "audio-pause-ic"
}

extension UIImage {
    
    static var albumPlaceholder: UIImage? {
        return UIImage(named: AppIcons.albumPlaceholder.rawValue)
    }
    
    static var imageDefaultPlaceholder: UIImage? {
        return UIImage(named: AppIcons.defaultImagePlaceholder.rawValue)
    }
    
    static var successIcon: UIImage? {
        return UIImage(named: AppIcons.successIcon.rawValue)
    }
    
    static var failureIcon: UIImage? {
        return UIImage(named: AppIcons.failureIcon.rawValue)
    }
    
    static var audioPlayIcon: UIImage? {
        return UIImage(named: AppIcons.audioPlayIcon.rawValue)
    }
    
    static var audioPauseIcon: UIImage? {
        return UIImage(named: AppIcons.audioPauseIcon.rawValue)
    }
}
