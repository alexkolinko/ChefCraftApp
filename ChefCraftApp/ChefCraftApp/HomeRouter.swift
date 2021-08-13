//
//  HomeRouter.swift
//  ChefCraftApp
//
//  Created by Work on 23.07.2021.
//

import Foundation
import UIKit

// MARK: - HomeRouterRoutes
/// Navigation routes for HomeView
//typealias HomeRouterRoutes =

// MARK: - HomeNavigation
/// Abstract navigation layer for HomeRouter
protocol HomeNavigationProtocol {
    
    func showCategoryDetails(details: HomeViewContent.CategoryCellItem)
    
    func showRecipeDetails(details: Recipe)
}

// MARK: - HomeRoute
class HomeRouter: Router<HomeViewController>, HomeRouter.Routes {
    
    typealias Routes = RecipeDetailsRoute & CategoryRecipesRoute
    
    var CategoryRecipesTransition: Transition {
        PushTransition()
    }
    
    var RecipeDetailsTransition: Transition {
        PushTransition()
    }
    
}

// MARK: - HomeRouter: InAppMessageDetailsNavigation
extension HomeRouter: HomeNavigationProtocol {
    
    func showCategoryDetails(details: HomeViewContent.CategoryCellItem) {
        self.showCategoryRecipes(item: details)
    }
    
    func showRecipeDetails(details: Recipe) {
        self.showRecipe(details)
    }
}
