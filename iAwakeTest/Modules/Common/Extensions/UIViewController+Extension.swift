//
//  UIViewController+Extension.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    /**
     Shows an alert with a title and a message
     */
    func showAlert(title: String, message:String, shouldPopView:Bool = false, shouldPopViewToRoot: Bool = false, shouldDismissView: Bool = false, completion:(() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // show the alert with a "ok" button that will close the alert
        let okAction = UIAlertAction(title: AppStrings.ok, style: UIAlertAction.Style.default) { (action)-> Void in
            if shouldDismissView {
                self.dismiss(animated: true, completion: nil)
            }
            else if shouldPopView {
                if shouldPopViewToRoot {
                    _ = self.navigationController?.popToRootViewController(animated: true)
                }
                else {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
            completion?()
        }
        alertController.addAction(okAction)
        
        // show alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAppLoader(disableUserInteraction: Bool = false) {
        DispatchQueue.main.async {
            if disableUserInteraction {
                self.view.isUserInteractionEnabled = !disableUserInteraction
            }
            self.view.showAppLoader()
        }
    }
    
    func hideAppLoader() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.view.hideAppLoader()
        }
    }
    
    func showToastMessage(message: String) {
        DispatchQueue.main.async {
            [weak self] in
            guard let self = self else { return }
            guard self.isViewLoaded else { return }
            UIUtil.showGlobalToast(message: message)
        }
        
    }
    
    func handleError(error: Error, defaultMessage: String? = nil) {
        if let genericError = error as? GenericError {
            self.showToastMessage(message: genericError.errorDescription!)
        }
        else if (error as NSError).domain == "FIRAuthErrorDomain"{
            self.showToastMessage(message: error.localizedDescription)
        }
        else if let msg = defaultMessage {
            showToastMessage(message: msg)
        }
        else {
            showAppInfoPopup(withTitle: AppStrings.Errors.errorTitle, message: AppStrings.Errors.couldNotCompleteRequest, icon: .failureIcon)
        }
    }
    
    func showAppInfoPopup(withTitle title: String, message: String? = nil, icon: UIImage? = nil, confirmText: String = AppStrings.ok, completion: (() -> Void)? = nil) {
        guard let appInfoAlertVC = UIStoryboard.getViewController(inStoryboard: .Common, identifier: .appInfoAlertVC) as? AppInfoAlertViewController else { return }
        appInfoAlertVC.shouldAddFullOverlay = true
        appInfoAlertVC.shouldDismissViewOnTapOutside = true
        appInfoAlertVC.setup(withTitle: title, message: message, icon: icon, confirmText: confirmText)
        appInfoAlertVC.onDismiss = completion
        appInfoAlertVC.modalPresentationStyle = .overCurrentContext
        self.present(appInfoAlertVC, animated: true, completion: nil)
    }
}
