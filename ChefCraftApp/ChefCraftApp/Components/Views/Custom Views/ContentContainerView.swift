//
//  ContentContainerView.swift
//  ChefCraftApp
//
//  Created by kolinko oleksandr on 24.01.2022.
//

import UIKit

class ContentContainerView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 20.0
    private var fillColor: UIColor = .white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpView()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.applyCorners()
    }
    
    private func setUpView() {
        self.clipsToBounds = true
        self.backgroundColor = fillColor
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func applyCorners() {
       self.layer.cornerRadius = cornerRadius
    }
}
