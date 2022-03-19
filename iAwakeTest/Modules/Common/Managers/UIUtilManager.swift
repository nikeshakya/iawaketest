//
//  UIUtilManager.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation
import UIKit
import Toast_Swift
import Lottie

struct AppElementTags {
    static let appLoaderTag = 1001
}

class UIUtil {
    
    static func showGlobalToast(message: String) {
        var windows: [UIWindow]!
        if #available(iOS 13.0, *) {
            guard let _windows = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows else { return }
            windows = _windows
        } else {
            windows = UIApplication.shared.windows
        }
        DispatchQueue.main.async {
            for window in windows {
                window.hideAllToasts()
                window.makeToast(message)
            }
        }
    }
    
    static func getAppLoader(height: CGFloat, width: CGFloat) -> AnimationView {
        let loader = AnimationView(name: "app_loader")
        loader.frame.size = CGSize(width: width, height: height)
        loader.backgroundBehavior = .pauseAndRestore
        loader.loopMode = .loop
        loader.backgroundColor = .clear
        loader.contentMode = .scaleAspectFit
        return loader
    }
}
