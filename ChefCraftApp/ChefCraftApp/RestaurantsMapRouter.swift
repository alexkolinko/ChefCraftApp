//
//  RestaurantsMapRouter.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//  
//

import Foundation

// MARK: - RestaurantsMapRouterRoutes
/// Navigation routes for RestaurantsMapView
//typealias RestaurantsMapRouterRoutes =

// MARK: - RestaurantsMapNavigation
/// Abstract navigation layer for RestaurantsMapRouter
protocol RestaurantsMapNavigation/*: RestaurantsMapRouterRoutes*/ {}

// MARK: - RestaurantsMapRouter
final class RestaurantsMapRouter: Router<RestaurantsMapViewController>, RestaurantsMapNavigation {
}
