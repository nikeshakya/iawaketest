//
//  CGFloat+Extension.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation
import UIKit

let minScalableValue: CGFloat = 8.0 // Min value that should undergo upper scaling for bigger iphones and iPads
extension CGFloat {
    
    func relativeToIphone8Width(shouldUseLimit: Bool = true, deviceWidth: CGFloat = UIScreen.main.bounds.width) -> CGFloat {
        let upperScaleLimit: CGFloat = 1.8
        var toUpdateValue = floor(self * (deviceWidth / 375))
        guard self > minScalableValue else {return toUpdateValue}
        guard shouldUseLimit else {return toUpdateValue}
        guard upperScaleLimit > 1 else {return toUpdateValue}
        let limitedValue = self * upperScaleLimit
        if toUpdateValue > limitedValue {
            toUpdateValue = limitedValue
        }
        return toUpdateValue
    }
    
    func relativeToIphone8Height(shouldUseLimit: Bool = true) -> CGFloat {
        var extraHeight: CGFloat = 0
        if #available(iOS 11.0, *) {
            var windows: [UIWindow]!
            if #available(iOS 13.0, *) {
                guard let _windows = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows else { return self }
                windows = _windows
            } else {
                windows = UIApplication.shared.windows
            }
            extraHeight = windows.first?.safeAreaInsets.bottom ?? 0
            extraHeight = extraHeight + (windows.first?.safeAreaInsets.top ?? 20) - 20
        }
        let upperScaleLimit: CGFloat = 1.8
        var toUpdateValue = floor(self * ((UIScreen.main.bounds.height - extraHeight) / 667))
        guard self > minScalableValue else {return toUpdateValue}
        guard shouldUseLimit else {return toUpdateValue}
        guard upperScaleLimit > 1 else {return toUpdateValue}
        let limitedValue = self * upperScaleLimit
        if toUpdateValue > limitedValue {
            toUpdateValue = limitedValue
        }
        return toUpdateValue
    }
    
    var deg2rad: CGFloat {
        return self * .pi / 180
    }
}

extension Int {
    var toCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    var toMinString: String {
        return "\(self) min"
    }
}
