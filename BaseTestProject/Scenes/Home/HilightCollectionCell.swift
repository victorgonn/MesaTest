//
//  CollectionCell.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 03/12/20.
//

import Foundation
import UIKit

class HilightCollectionCell: UICollectionViewCell {
    var selectedAction: (() -> Void)?
    
    let imgView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds =  true
        imgView.backgroundColor = UIColor.Theme.primary
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let titleLabel: Label = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedClick))
        self.addGestureRecognizer(tap)
        
        self.backgroundColor = UIColor.Theme.primary
        let img = isFavorited == true ? favoritImage : nFavoritImage
        favoritButton.setImage(img, for: UIControl.State.normal)
        favoritButton.addTarget(self, action: #selector(fbuttonClicked), for: .touchUpInside)

        addSubview(imgView)
        addSubview(titleLabel)
        addSubview(favoritButton)
        bringSubviewToFront(favoritButton)
        setupLayout()
    }
    
    private func setupLayout(){
        
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(3)
            make.left.equalTo(snp.left).offset(3)
            make.right.equalTo(snp.right).offset(-3)
            make.bottom.equalTo(snp.bottom).offset(-3)
        }
        
        favoritButton.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(3)
            make.right.equalTo(snp.right).offset(-3)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
    
    @objc fileprivate func fbuttonClicked(){
        isFavorited = !isFavorited
        let img = isFavorited == true ? favoritImage : nFavoritImage
        favoritButton.setImage(img, for: UIControl.State.normal)
    }
    
    @objc fileprivate func selectedClick() {
        self.selectedAction?()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
