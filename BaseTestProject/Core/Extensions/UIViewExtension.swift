//
//  UIViewExtension.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 29/11/20.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    public func fillSuperview(toSafeArea: Bool? = true) {
        guard let superview = self.superview else { return }
        self.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *), toSafeArea == true {
                make.top.equalTo(superview.safeAreaLayoutGuide.snp.top)
                make.left.equalTo(superview.safeAreaLayoutGuide.snp.left)
                make.right.equalTo(superview.safeAreaLayoutGuide.snp.right)
                make.bottom.equalTo(superview.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(superview.snp.top)
                make.left.equalTo(superview.snp.left)
                make.right.equalTo(superview.snp.right)
                make.bottom.equalTo(superview.snp.bottom)
            }
        }
    }
    
    public func remakeBottonConstraint(constraint: CGFloat, toSafeArea: Bool? = true) {
        guard let superview = self.superview else { return }
        self.snp.remakeConstraints { (make) in
            if #available(iOS 11.0, *), toSafeArea == true {
                make.top.equalTo(superview.safeAreaLayoutGuide.snp.top)
                make.left.equalTo(superview.safeAreaLayoutGuide.snp.left)
                make.right.equalTo(superview.safeAreaLayoutGuide.snp.right)
                make.bottom.equalTo(superview.safeAreaLayoutGuide.snp.bottom).offset(constraint)
            } else {
                make.top.equalTo(superview.snp.top)
                make.left.equalTo(superview.snp.left)
                make.right.equalTo(superview.snp.right)
                make.bottom.equalTo(superview.snp.bottom).offset(constraint)
            }
        }
    }
    
    public static func drawCircleBackgroundView(with color: UIColor,
                                                contrastColor: UIColor = .white,
                                                heightPercent: CGFloat = 0.6,
                                                circleCenterHeight: CGFloat = 0) -> UIView {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        backgroundView.backgroundColor = color
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.width/2, y: circleCenterHeight),
                                      radius: CGFloat(UIScreen.main.bounds.height * heightPercent),
                                      startAngle: CGFloat(0),
                                      endAngle: CGFloat(Double.pi * 2),
                                      clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath

        shapeLayer.fillColor = contrastColor.cgColor
        shapeLayer.strokeColor = contrastColor.cgColor
        shapeLayer.lineWidth = 3.0
        backgroundView.layer.addSublayer(shapeLayer)
        return backgroundView
    }
}

