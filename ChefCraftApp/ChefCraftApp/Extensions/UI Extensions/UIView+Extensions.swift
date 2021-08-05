//
//  UIView+Extensions.swift
//  ChefCraftApp
//
//  Created by Work on 05.08.2021.
//

import Foundation
import UIKit

extension UIView {
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
    }
}
