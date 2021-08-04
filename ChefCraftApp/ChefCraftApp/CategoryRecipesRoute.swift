//
//  CategoryRecipesRoute.swift
//  shell
//
//  Created by Work on 04.08.2021.
//  Copyright © 2021 CoreTeka. All rights reserved.
//

import Foundation

protocol CategoryRecipesRoute {
    var CategoryRecipesTransition: Transition { get }
    
    func showCategoryRecipes(item: HomeViewContent.CategoryCellItem)
}

extension CategoryRecipesRoute where Self: RouterProtocol {
    
    func showCategoryRecipes(item: HomeViewContent.CategoryCellItem) {
        let viewController = CategoryRecipesBuilder.build(injector: injector)
        open(viewController, transition: CategoryRecipesTransition)
    }
}
