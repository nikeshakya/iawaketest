//
//  AdaptiveLayoutConstraint.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import UIKit

class AdaptiveLayoutConstraint: NSLayoutConstraint {
    
    @IBInspectable var setAdaptiveLayout: Bool = false {
        didSet {
        }
    }
    
    override func awakeFromNib() {
        if setAdaptiveLayout {
            self.constant = self.constant.relativeToIphone8Width()
            
            if let firstView = self.firstItem as? UIView {
                firstView.layoutIfNeeded()
            }
            if let secondVIew = self.secondItem as? UIView {
                secondVIew.layoutIfNeeded()
            }
        }
    }
    
}
