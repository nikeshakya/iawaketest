//
//  UIImageView+Extension.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation
import UIKit
import SDWebImage

extension UIImage {
    
    func isTransparent() -> Bool {
        guard let alpha: CGImageAlphaInfo = self.cgImage?.alphaInfo else { return false }
        return alpha == .first || alpha == .last || alpha == .premultipliedFirst || alpha == .premultipliedLast
    }
    
    class func colorForNavBar(color: UIColor) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 1.0, height: 1.0))
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        return image!
    }
}

extension UIImageView {
    
    func setImage(withUrlString urlString: String, defaultImage: Data? = nil, placeholderImage: UIImage? = UIImage.imageDefaultPlaceholder, options: SDWebImageOptions = [.refreshCached, .retryFailed], completion: SDExternalCompletionBlock? = nil) {
        var placeholder = placeholderImage
        if let defaultImage = defaultImage, let img = UIImage(data: defaultImage) {
            placeholder = img
        }
        guard let url = URL(string: urlString) else {
            self.image = placeholderImage
            return
        }
        self.sd_setImage(with: url, placeholderImage: placeholder, options: options, completed: completion)
    }
}
