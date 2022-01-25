//
//  RestaurantsMapRoute.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//  
//

import Foundation

protocol RestaurantsMapRoute {
    var RestaurantsMapTransition: Transition { get }
    
    func showRecipesMap()
}

extension RestaurantsMapRoute where Self: RouterProtocol {
    
    func showRecipesMap() {
        let viewController = RestaurantsMapBuilder.build(injector: injector)
        open(viewController, transition: RestaurantsMapTransition)
    }
}
