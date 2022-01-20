//
//  RecipesMapRouter.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//  
//

import Foundation

// MARK: - RecipesMapRouterRoutes
/// Navigation routes for RecipesMapView
//typealias RecipesMapRouterRoutes =

// MARK: - RecipesMapNavigation
/// Abstract navigation layer for RecipesMapRouter
protocol RecipesMapNavigation/*: RecipesMapRouterRoutes*/ {}

// MARK: - RecipesMapRouter
final class RecipesMapRouter: Router<RecipesMapViewController>, RecipesMapNavigation {
}
