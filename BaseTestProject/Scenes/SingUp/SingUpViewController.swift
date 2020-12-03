//
//  SingUpViewController.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 02/12/20.
//

import Foundation
import UIKit

protocol SingUpViewControllerDelegate: class {
    func navigateToLogin()
    func navigateToHome()
}

public class SingUpViewController: BaseViewController {
    var contentView: SingUpView!
    var viewModel: SingUpViewModel = SingUpViewModel()
    var delegate: SingUpViewControllerDelegate?

    public override func loadView() {
        super.loadView()
        contentView = SingUpView()
        self.view.addSubview(contentView)
        contentView.fillSuperview()
        keyboardProtocol = self
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    
    fileprivate func configureButtons() {
        self.contentView.buttonAction = {
            self.updateNewUserData()
        }
    }
    
    func updateNewUserData() {
        switch self.viewModel.actualStep {
        case .password:
            self.viewModel.actualStep = .confPassword
            self.viewModel.singUpRequest.password = self.contentView.dataField.text
        case .confPassword:
            self.contentView.dataField.resetHint()
            if self.contentView.dataField.text == self.viewModel.singUpRequest.password {
                self.showLoading(true)
                self.viewModel.createAccount().then(on: .main) { response in
                    self.showLoading(false)
                    UserDefaultsUtils.saveAccessToken(value: response.token)
                    self.delegate?.navigateToHome()
                }.catch(on: .main) { error in
                    self.showLoading(false)
                    if let error = error as? ErrorResponse {
                        self.handleError(msg: error.message)
                    }
                }
            } else {
                self.handleError(msg: "As senhas digitadas nao sao iguais.")
            }
        case .email:
            self.viewModel.actualStep = .password
            self.viewModel.singUpRequest.email = self.contentView.dataField.text
        default:
            self.viewModel.actualStep = .email
            self.viewModel.singUpRequest.name = self.contentView.dataField.text

        }
        self.contentView.fluxStep = self.viewModel.actualStep
    }
    
    fileprivate func handleError(msg: String) {
        self.contentView.dataField.displayError(msg)
    }
}

extension SingUpViewController: KeyboardIsUpProtocol {
    func resizeScroll(keyboardSize: CGFloat?) {
        //resizeScroll
    }
    
    func keyboardIsOpen(isOpen: Bool) {
        let keyboardHeight = self.keyboardSize ?? 0
        if isOpen {
            self.contentView.remakeBottonConstraint(constraint:  -keyboardHeight, toSafeArea: true)
        } else {
            self.contentView.remakeBottonConstraint(constraint:  0, toSafeArea: true)
        }
    }
}

