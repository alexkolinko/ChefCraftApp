//
//  RecipeDetailsRoute.swift
//  ChefCraftApp
//
//  Created by Work on 29.07.2021.
//

import Foundation

protocol RecipeDetailsRoute {
    var RecipeDetailsTransition: Transition { get }
    
    func showRecipe(_ details: Recipe)
}

extension RecipeDetailsRoute where Self: RouterProtocol {
    
    func showRecipe(_ details: Recipe) {
        let viewController = RecipeDetailsBuilder.build(injector: injector, details: details)
        open(viewController, transition: RecipeDetailsTransition)
    }
}
