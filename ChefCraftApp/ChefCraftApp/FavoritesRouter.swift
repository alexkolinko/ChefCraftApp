//
//  FavoritesRouter.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import Foundation

// MARK: - FavoritesNavigation
/// Abstract navigation layer for FavoritesRouter
protocol FavoritesNavigation {
    
}

// MARK: - FavoritesRoute
class FavoritesRouter: Router<FavoritesViewController>, FavoritesNavigation {
}
