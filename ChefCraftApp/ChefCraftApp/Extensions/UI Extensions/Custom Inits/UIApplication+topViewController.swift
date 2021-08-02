//
//  UIApplication+topViewController.swift
//  ChefCraftApp
//
//  Created by Work on 29.07.2021.
//

import Foundation
import UIKit

// MARK: - Top View Controller
extension UIApplication {
    // special extension for call from seperate class present UIController
    // you can use it : UIApplication.topViewController()?.present(..)
    class func topViewController(base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
