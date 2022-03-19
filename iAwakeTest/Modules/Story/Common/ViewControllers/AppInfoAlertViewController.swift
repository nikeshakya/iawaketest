//
//  AppInfoAlertViewController.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import UIKit

class AppInfoAlertViewController: AppPopupViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusIconView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageStackView: UIStackView!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBAction func confirmTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private var titleText: String = AppStrings.appName
    private var message: String?
    private var statusIcon: UIImage?
    private var confirmText: String = AppStrings.ok
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func setup(withTitle title: String, message: String? = nil, icon: UIImage? = nil, confirmText: String = AppStrings.ok) {
        self.titleText = title
        self.message = message
        self.statusIcon = icon
        self.confirmText = confirmText
    }
    
    private func configureView() {
        self.titleLabel.text = titleText
        self.messageLabel.text = message
        self.statusIconView.image = statusIcon
        messageLabel.isHidden = message == nil
        statusIconView.isHidden = statusIcon == nil
        messageStackView.isHidden = (messageLabel.isHidden && statusIconView.isHidden)
        confirmButton.setTitle(confirmText, for: .normal)
    }

}
