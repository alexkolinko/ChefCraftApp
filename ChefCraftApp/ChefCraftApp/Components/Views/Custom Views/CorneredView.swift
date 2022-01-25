//
//  CorneredView.swift
//  ChefCraftApp
//
//  Created by kolinko oleksandr on 24.01.2022.
//

import UIKit
import Foundation

class CorneredView: UIView {
    
    @IBInspectable var corner: CGFloat = 10.0

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
        self.layer.cornerRadius = corner
    }
    
    private func setUpView() {
        self.clipsToBounds = true
    }
}
