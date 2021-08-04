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
    func showRecipeDetails(details: HomeViewContent.RecipeCellItem)
}

// MARK: - HomeRoute
class HomeRouter: Router<HomeViewController>, HomeRouter.Routes {
    
    typealias Routes = RecipeDetailsRoute
    
    var RecipeDetailsTransition: Transition {
        PushTransition()
    }
    
}

// MARK: - HomeRouter: InAppMessageDetailsNavigation
extension HomeRouter: HomeNavigationProtocol {
    func showRecipeDetails(details: HomeViewContent.RecipeCellItem) {
        self.showDetails(details)
    }
}
