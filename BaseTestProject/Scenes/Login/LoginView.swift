//
//  LoginView.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 26/11/20.
//

import UIKit
import SnapKit
import FBSDKLoginKit

public enum HeaderType {
    case thin
    case fat
}

class LoginView: BaseView {
    var buttonAction: (() -> Void)?
    
    let headerBackGroundView: UIView = {
        let background = UIView()
        background.backgroundColor = UIColor.Theme.primary
        background.layer.cornerRadius = 25
        background.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return background
    }()
    
    let headerLogoImage: UIImageView = {
        let background = UIImageView(image: UIImage(named: "MesaM"))
        background.contentMode = .scaleAspectFit
        return background
    }()
    
    let emailField = TextField()
    let passwordField = TextField()
    let actionButton = ActionButton()
    let loginButton = FBLoginButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        emailField.configureTextField(text: "Email", hint: nil, maxLeght: nil)
        emailField.setTextFieldTag(with: 1)
        passwordField.configureTextField(text: "Senha", hint: nil, maxLeght: nil)
        passwordField.setPasswordLayout()
        passwordField.setTextFieldTag(with: 2)
        
        actionButton.configureButton(title: "ENTRAR", titleColor: UIColor.Theme.textColor2)
        actionButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        buildViewHierarchy()
        setupConstraints()
    }
    
    public func buildViewHierarchy() {
        addSubview(headerBackGroundView)
        headerBackGroundView.addSubview(headerLogoImage)
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(actionButton)
        addSubview(loginButton)
    }
    
    public func setupConstraints() {
        headerBackGroundView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.height.equalTo(200)
        }
        
        headerLogoImage.snp.makeConstraints { (make) in
            make.center.equalTo(headerBackGroundView.snp.center)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
    
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(headerBackGroundView.snp.bottom).offset(40)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
        }

        passwordField.snp.makeConstraints { (make) in
            make.top.equalTo(emailField.snp.bottom).offset(16)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
        }
        
        actionButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordField.snp.bottom).offset(40)
            make.left.equalTo(snp.left).offset(31)
            make.right.equalTo(snp.right).offset(-31)
            make.height.equalTo(48)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(actionButton.snp.bottom).offset(20)
            make.centerX.equalTo(snp.centerX)
        }
    }
    
    public func rebuildHeaderConstraints(headerType: HeaderType) {
        switch headerType {
        case .thin:
            headerBackGroundView.snp.remakeConstraints { (make) in
                make.top.equalTo(snp.top)
                make.left.equalTo(snp.left)
                make.right.equalTo(snp.right)
                make.height.equalTo(100)
            }
        default:
            headerBackGroundView.snp.remakeConstraints { (make) in
                make.top.equalTo(snp.top)
                make.left.equalTo(snp.left)
                make.right.equalTo(snp.right)
                make.height.equalTo(200)
            }
        }
    }
    
    @objc fileprivate func buttonClick() {
        self.buttonAction?()
    }
}
