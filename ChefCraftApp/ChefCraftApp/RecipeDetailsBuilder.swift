//
//  RecipeDetailsBuilder.swift
//  ChefCraftApp
//
//  Created by Work on 29.07.2021.
//

import Foundation
import UIKit
import Swinject

class RecipeDetailsBuilder {
    static func build(injector: Container, details: HomeViewContent.RecipeCellItem) -> RecipeDetailsViewController {
        let viewController = RecipeDetailsViewController.board(.RecipeDetails)

        let router = RecipeDetailsRouter(injector: injector)
        router.viewController = viewController
        
        let interactor = RecipeDetailsInteractorImpl()
        
        let presenter = RecipeDetailsPresenter(router: router, interactor: interactor, details: details)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
