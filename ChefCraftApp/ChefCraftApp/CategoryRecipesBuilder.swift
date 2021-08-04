//
//  CategoryRecipesBuilder.swift
//  shell
//
//  Created by Work on 04.08.2021.
//  Copyright © 2021 CoreTeka. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class CategoryRecipesBuilder {
    static func build(injector: Container) -> CategoryRecipesViewController {
        let viewController = CategoryRecipesViewController.board(.CategoryRecipes)

        let router = CategoryRecipesRouter(injector: injector)
        router.viewController = viewController
        
        let interactor = CategoryRecipesInteractorImpl()
        
        let presenter = CategoryRecipesPresenter(router: router, interactor: interactor)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
