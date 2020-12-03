//
//  SingUpView.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 02/12/20.
//

import UIKit
import SnapKit

public enum SingUpFlux {
    case name
    case email
    case password
    case confPassword
}

class SingUpView: BaseView {
    var buttonAction: (() -> Void)?
    
    let textLabel = Label()
    let dataField = TextField()
    
    var fluxStep: SingUpFlux = .name {
        didSet {
            reorganizeView()
        }
    }
    
    let actionButton = ActionButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        textLabel.setStyle(FontStyle.f14PrimaryRegular, text: "Para seguir com o cadastro, é fundamental que voce digite seu \(fluxStep)", color: UIColor.Theme.textColor0, enabledUppercase: false, numeberOfLines: 0, name: nil)
        dataField.configureTextField(text: "Nome Completo", hint: nil, maxLeght: nil)
        dataField.setTextFieldTag(with: 1)
        
        actionButton.configureButton(title: "Continuar", titleColor: UIColor.Theme.textColor2)
        actionButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        buildViewHierarchy()
        setupConstraints()
    }
    
    func reorganizeView() {
        switch self.fluxStep {
        case .password:
            textLabel.setText("Para seguir com o cadastro, é fundamental que voce digite seu \(fluxStep)")
            dataField.configureTextField(text: "Senha", hint: nil, maxLeght: nil)
            dataField.setPasswordLayout()
            dataField.textField.text = ""
        case .confPassword:
            textLabel.setText("Para seguir com o cadastro, é fundamental que voce digite sua confirmacao de password")
            dataField.configureTextField(text: "Confirmar Senha", hint: nil, maxLeght: nil)
            dataField.setPasswordLayout()
            dataField.textField.text = ""
        case .email:
            textLabel.setText("Para seguir com o cadastro, é fundamental que voce digite seu \(fluxStep)")
            dataField.configureTextField(text: "E-mail", hint: nil, maxLeght: nil)
            dataField.textField.text = ""
            dataField.removePasswordLayout()
        default:
            textLabel.setText("Para seguir com o cadastro, é fundamental que voce digite seu \(fluxStep)")
            dataField.configureTextField(text: "Nome Completo", hint: nil, maxLeght: nil)
            dataField.textField.text = ""
            dataField.removePasswordLayout()
        }
    }
    
    public func buildViewHierarchy() {
        addSubview(textLabel)
        addSubview(dataField)
        addSubview(actionButton)
    }
    
    public func setupConstraints() {
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(24)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
        }
        
        dataField.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom).offset(24)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
        }
        
        actionButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(snp.bottom).offset(-24)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.height.equalTo(48)
        }
    }
    
    
    @objc fileprivate func buttonClick() {
        self.buttonAction?()
    }
}
