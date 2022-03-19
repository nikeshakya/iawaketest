//
//  RoundedView.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation
import UIKit

@IBDesignable
class RoundedView: UIView {
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            updateBorders()
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var isCircular: Bool = false {
        didSet {
            if isCircular {
                cornerRadius = self.frame.width / 2
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var displayShadow: Bool = false {
        didSet {
            if displayShadow == true {
                addShadow()
            }
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
                layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    private func addShadow() {
        let layer = self.layer
        layer.masksToBounds = true
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        if let shadowClr = shadowColor {
            layer.masksToBounds = false
            layer.shadowColor = shadowClr.cgColor
        }
        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
        
        let bColor = self.backgroundColor?.cgColor
        self.backgroundColor = nil
        layer.backgroundColor =  bColor
        if isCircular {
            self.cornerRadius = self.frame.width / 2
        }
        else {
            self.layer.cornerRadius = cornerRadius.relativeToIphone8Width()
        }
    }
    
    override func awakeFromNib() {
        if isCircular {
            self.cornerRadius = self.frame.width / 2
        }
        else {
            self.layer.cornerRadius = cornerRadius.relativeToIphone8Width()
        }
        if displayShadow {
            addShadow()
        }
        updateBorders()
    }
    
    override func layoutSubviews() {
        if isCircular {
            self.cornerRadius = self.frame.width / 2
        }
        if displayShadow {
            addShadow()
        }
        updateBorders()
    }
    
    private func updateBorders() {
        layer.borderWidth = borderWidth
        if borderWidth > 2 {
            self.layer.borderWidth = borderWidth.relativeToIphone8Width()
        }
    }
}
