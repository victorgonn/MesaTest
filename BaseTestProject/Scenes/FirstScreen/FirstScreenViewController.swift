//
//  FirstScreenViewController.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 01/12/20.
//

import Foundation
import UIKit
import FBSDKLoginKit

protocol FirstScreenViewControllerDelegate: class {
    func navigateToSingUp()
    func navigateToLogin()
    func navigateToHome()
}

public class FirstScreenViewController: BaseViewController {
    var contentView: FirstScreenView!
    var delegate: FirstScreenViewControllerDelegate?

    public override func loadView() {
        super.loadView()
        hideNavigationBar = true
        contentView = FirstScreenView()
        self.view.addSubview(contentView)
        contentView.fillSuperview(toSafeArea: false)
    }
    
    public override func viewDidLoad() {
        configureButtons()
        if let token = AccessToken.current, !token.isExpired {
            self.delegate?.navigateToHome()
        }
    }
    
    fileprivate func configureButtons() {
        contentView.loginButtonAction = {
            self.delegate?.navigateToLogin()
        }
        
        contentView.singUpButtonAction = {
            self.delegate?.navigateToSingUp()
        }
    }
}
