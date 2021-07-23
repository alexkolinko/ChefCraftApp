//
//  Transition.swift
//  ChefCraftApp
//
//  Created by Work on 23.07.2021.
//

import Foundation
import UIKit

protocol Transition: AnyObject {
    var viewController: UIViewController? { get set }

    func open(_ viewController: UIViewController)
    func close(_ viewController: UIViewController)
}
