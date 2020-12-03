//
//  ActionButton.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 27/11/20.
//

import Foundation
import UIKit
import SnapKit

public class ActionButton: UIButton {
    override public var isEnabled: Bool {
        didSet {
            backgroundColor = self.isEnabled ? UIColor.Theme.primary : UIColor.Theme.fieldBackground
            self.setTitleColor(self.isEnabled ? titleColor : UIColor.Theme.textColor1, for: .normal)
        }
    }
    
    convenience init(title: String) {
        self.init()
        configureButton(title: title, titleColor: UIColor.Theme.textColor2)
    }
    
    var titleColor: UIColor = UIColor.Theme.background
    
    public func configureButton(title: String, color: UIColor? = UIColor.Theme.primary, borderColor: UIColor? = UIColor.Theme.primary, titleColor: UIColor) {
        setTitle(title.uppercased(), for: .normal)
        layer.cornerRadius = 8
    
        guard let titleLabel = titleLabel else { return }
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = FontStyle.f16PrimaryRegular.font
        
        self.titleColor = titleColor
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = color
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor?.cgColor
    }
    
}
