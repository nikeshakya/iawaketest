//
//  UIView+Extension.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func setViewVisibility(hidden: Bool, duration: TimeInterval, completion: ((Bool) -> Void)?) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.isHidden = hidden
            }, completion: completion)
    }
    
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.masksToBounds = true;
    }
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func showAppLoader(withSize size: CGFloat = 100, clearBackground: Bool = true, useFullScreen: Bool = true) {
        let size = size.relativeToIphone8Width()
        let appLoader = UIUtil.getAppLoader(height: size, width: size)
        appLoader.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        if clearBackground {
            appLoader.backgroundColor = .clear
        }
        else {
            appLoader.backgroundColor = .white
        }
        appLoader.setRadius(radius: CGFloat(10).relativeToIphone8Width())
        appLoader.tag = AppElementTags.appLoaderTag
        self.hideAppLoader()
        appLoader.center = self.center
        self.addSubview(appLoader)
        appLoader.translatesAutoresizingMaskIntoConstraints = false
        appLoader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        if let window = self.window {
            let windowSafeAreaVerticalOffset = window.safeAreaInsets.top + window.safeAreaInsets.bottom
            let windowActualHeight = window.frame.height - windowSafeAreaVerticalOffset
            let diff = self.frame.height - windowActualHeight
            appLoader.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: (useFullScreen ? diff/2 : 0)).isActive = true
        }
        else {
            appLoader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
        appLoader.widthAnchor.constraint(equalToConstant: size).isActive = true
        appLoader.heightAnchor.constraint(equalToConstant: size).isActive = true
        self.bringSubviewToFront(appLoader)
        appLoader.play()
    }
    
    func hideAppLoader() {
        while let appLoader = self.viewWithTag(AppElementTags.appLoaderTag) {
            appLoader.removeFromSuperview()
        }
    }
    
    func hideAppLoader(withTag tag: Int) {
        while let appLoader = self.viewWithTag(tag) {
            appLoader.removeFromSuperview()
        }
    }
}

extension UITableView {
    open override func awakeFromNib() {
        self.tableFooterView = UIView(frame: .zero)
    }
    
    func scrollToLastItem(animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        if (rows > 0){
            DispatchQueue.main.async {
                self.scrollToRow(at: IndexPath(row: rows - 1, section: sections - 1), at: .bottom, animated: animated)
            }
        }
    }
}

extension UIScrollView {

    func scrollToBottom(animated: Bool) {
        var y: CGFloat = 0.0
        let HEIGHT = self.frame.size.height
        if self.contentSize.height > HEIGHT {
            y = self.contentSize.height - HEIGHT
        }
        DispatchQueue.main.async {
            self.setContentOffset(CGPoint(x: 0, y: y), animated: animated)
        }
    }
}
