//
//  RecipesMapRoute.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//  
//

import Foundation

protocol RecipesMapRoute {
    var RecipesMapTransition: Transition { get }
    
    func showRecipesMap()
}

extension RecipesMapRoute where Self: RouterProtocol {
    
    func showRecipesMap() {
        let viewController = RecipesMapBuilder.build(injector: injector)
        open(viewController, transition: RecipesMapTransition)
    }
}
