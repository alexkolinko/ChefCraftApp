//
//  RootRoute.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import Foundation

protocol RootRoute {
    var RootViewTransition: Transition { get }
    
    func showRoot()
}

extension RootRoute where Self: RouterProtocol {
    
    func showRoot() {
        let viewController = RootBuilder.build(injector: injector)
        open(viewController, transition: RootViewTransition)
    }
}
