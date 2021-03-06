//
//  HomeViewCells.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 30/11/20.
//

import Foundation
import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {
    var selectedAction: (() -> Void)?
    
    let imgView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds =  true
        imgView.backgroundColor = UIColor.Theme.fieldBackground
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let titleLabel: Label = {
        let label = Label()
        return label
    }()
    
    let descriptionLabel: Label = {
        let label = Label()
        return label
    }()
    
    let favoritImage: UIImage? = UIImage(named: "star")
    let nFavoritImage: UIImage? = UIImage(named: "favorites-star-outlined-symbol")
    
    public var isFavorited: Bool = false {
        didSet{
            let img = isFavorited == true ? UIImage(named: "star") : UIImage(named: "favorites-star-outlined-symbol")
            favoritButton.setImage(img, for: UIControl.State.normal)
        }
    }
    
    let favoritButton: UIButton = {
        let fbutton = UIButton()
        return fbutton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
        
    func setupView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedClick))
        self.addGestureRecognizer(tap)
        
        self.backgroundColor = UIColor.Theme.fieldBackground
        let img = isFavorited == true ? favoritImage : nFavoritImage
        favoritButton.setImage(img, for: UIControl.State.normal)
        favoritButton.addTarget(self, action: #selector(fbuttonClicked), for: .touchUpInside)

        addSubview(imgView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(favoritButton)
        bringSubviewToFront(favoritButton)
        setupLayout()
    }
    
    private func setupLayout(){
        let width = self.frame.width
        
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.bottom.equalTo(snp.bottom)
            make.width.equalTo(width/3)
        }
        
        favoritButton.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(3)
            make.left.equalTo(snp.left).offset(3)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(3)
            make.left.equalTo(imgView.snp.right).offset(3)
            make.right.equalTo(snp.right).offset(-3)
            make.height.equalTo(50)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalTo(imgView.snp.right).offset(3)
            make.right.equalTo(snp.right).offset(-3)
            make.bottom.equalTo(snp.bottom)
        }
    }
    
    @objc fileprivate func fbuttonClicked(){
        self.isFavorited = !isFavorited
    }
    
    @objc fileprivate func selectedClick() {
        self.selectedAction?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
