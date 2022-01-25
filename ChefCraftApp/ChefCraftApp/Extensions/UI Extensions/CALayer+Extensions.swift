//
//  CALayer+Extensions.swift
//  ChefCraftApp
//
//  Created by kolinko oleksandr on 24.01.2022.
//

import Foundation
import UIKit

// MARK: - CALayer
extension CALayer {
    
    /// Add layer transition without using duration and animations
    ///
    /// - Parameter actionsWithoutAnimation: clouser for action
    func performWithoutAnimation(_ actionsWithoutAnimation: () -> Void) {
        CATransaction.begin()
        CATransaction.setValue(true, forKey: kCATransactionDisableActions)
        actionsWithoutAnimation()
        CATransaction.commit()
    }
    
    func makeShadow(color: UIColor, x: CGFloat = 0, y: CGFloat = 0, blur: CGFloat = 0, spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = 1
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let rect = bounds.insetBy(dx: -spread, dy: -spread)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func applySketchShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 4, spread: CGFloat = 0) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}
