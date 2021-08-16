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
    static func build(injector: Container, category: CategoryRecipes) -> CategoryRecipesViewController {
        let viewController = CategoryRecipesViewController.board(.CategoryRecipes)
        
        let router = CategoryRecipesRouter(injector: injector)
        router.viewController = viewController
        
        let interactor = CategoryRecipesInteractorImpl(category: category)
        
        let presenter = CategoryRecipesPresenter(router: router, interactor: interactor)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
