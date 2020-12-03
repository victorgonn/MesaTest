//
//  FirstScreenView.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 01/12/20.
//

import UIKit
import SnapKit


class FirstScreenView: BaseView {
    var loginButtonAction: (() -> Void)?
    var singUpButtonAction: (() -> Void)?
    
    let headerLogoImage: UIImageView = {
        let background = UIImageView(image: UIImage(named: "logoLogin"))
        background.contentMode = .scaleAspectFit
        return background
    }()
    
    let loginButton = ActionButton()
    let singupButton = ActionButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.Theme.primary
        
        loginButton.configureButton(title: "ENTRAR", color: UIColor.Theme.background, borderColor: UIColor.Theme.primary, titleColor: UIColor.Theme.primary )
        loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        
        singupButton.configureButton(title: "CADASTRAR", color: UIColor.clear, borderColor: UIColor.Theme.background, titleColor: UIColor.Theme.textColor2)
        singupButton.addTarget(self, action: #selector(singUpButtonClick), for: .touchUpInside)
        
        buildViewHierarchy()
        setupConstraints()
    }
    
    public func buildViewHierarchy() {
        addSubview(headerLogoImage)
        addSubview(singupButton)
        addSubview(loginButton)
    }
    
    public func setupConstraints() {
        headerLogoImage.snp.makeConstraints { (make) in
            make.center.equalTo(snp.center)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        singupButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(loginButton.snp.top).offset(-30)
            make.left.equalTo(snp.left).offset(31)
            make.right.equalTo(snp.right).offset(-31)
            make.height.equalTo(48)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(snp.bottom).offset(-20)
            make.left.equalTo(snp.left).offset(31)
            make.right.equalTo(snp.right).offset(-31)
            make.height.equalTo(48)
        }
    }
    
    @objc fileprivate func loginButtonClick() {
        self.loginButtonAction?()
    }
    
    @objc fileprivate func singUpButtonClick() {
        self.singUpButtonAction?()
    }
}
