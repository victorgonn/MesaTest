//
//  HomeView.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 30/11/20.
//

import UIKit
import SnapKit

class HomeHeaderView: BaseView {
    let headerLabel: Label = {
        let label = Label()
        return label
    }()
    
    let spacingView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        buildViewHierarchy()
        setupConstraints()
    }
    
    func setStyle(title: String, color: UIColor) {
        headerLabel.setStyle(FontStyle.f18PrimaryBold, text: title, color: color, enabledUppercase: false, numeberOfLines: 0, name: "")
        spacingView.backgroundColor = color
    }
    
    public func buildViewHierarchy() {
        addSubview(headerLabel)
        addSubview(spacingView)
    }
    
    public func setupConstraints() {
        headerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(-10)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
        }
        
        spacingView.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(7)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.height.equalTo(3)
        }

    }
}
