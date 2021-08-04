//
//  CategoryRecipesBuilder.swift
//  ChefCraftApp
//
//  Created by Work on 04.08.2021.
//

import Foundation
import UIKit
import Swinject

class CategoryRecipesBuilder {
    static func build(injector: Container, category: HomeViewContent.CategoryCellItem) -> CategoryRecipesViewController {
        let viewController = CategoryRecipesViewController.board(.CategoryRecipes)
        
        let router = CategoryRecipesRouter(injector: injector)
        router.viewController = viewController
        
        let interactor = CategoryRecipesInteractorImpl()
        
        let presenter = CategoryRecipesPresenter(router: router, interactor: interactor, category: category)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
