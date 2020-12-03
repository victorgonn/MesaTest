//
//  LoadingView.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 26/11/20.
//

import Foundation
import UIKit
import SnapKit

class LoadingView: UIView, ConfigurableView {
    
    let loadView : UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            loader.tintColor = UIColor.Theme.primary
            loader.translatesAutoresizingMaskIntoConstraints = false
            loader.startAnimating()
            return loader
        }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        customizeView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func customizeView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    func buildViewHierarchy() {
        addSubview(loadView)
     }
     
    func setupConstraints() {
        loadView.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(72)
            make.height.equalTo(72)
        }
    }

}
