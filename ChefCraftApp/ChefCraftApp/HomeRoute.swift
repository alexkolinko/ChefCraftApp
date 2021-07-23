//
//  HomeRoute.swift
//  ChefCraftApp
//
//  Created by Work on 23.07.2021.
//

import Foundation

protocol HomeRoute {
    var HomeTransition: Transition { get }
    
    func showHome()
}

extension HomeRoute where Self: RouterProtocol {
    
    func showHome() {
        let viewController = HomeBuilder.build(injector: injector)
        open(viewController, transition: HomeTransition)
    }
}
