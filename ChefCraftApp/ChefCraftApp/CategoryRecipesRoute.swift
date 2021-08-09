//
//  CategoryRecipesRoute.swift
//  ChefCraftApp
//
//  Created by Work on 04.08.2021.
//

import Foundation

protocol CategoryRecipesRoute {
    var CategoryRecipesTransition: Transition { get }
    
    func showCategoryRecipes(item: HomeViewContent.CategoryCellItem)
}

extension CategoryRecipesRoute where Self: RouterProtocol {
    
    func showCategoryRecipes(item: HomeViewContent.CategoryCellItem) {
        let viewController = CategoryRecipesBuilder.build(injector: injector, category: item)
        open(viewController, transition: CategoryRecipesTransition)
    }
}
