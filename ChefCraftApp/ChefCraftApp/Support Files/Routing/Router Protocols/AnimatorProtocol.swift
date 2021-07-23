//
//  AnimatorProtocol.swift
//  ChefCraftApp
//
//  Created by Work on 23.07.2021.
//

import UIKit

protocol AnimatorProtocol: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
