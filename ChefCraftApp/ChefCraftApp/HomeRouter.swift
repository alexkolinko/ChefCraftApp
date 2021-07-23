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
    
}

// MARK: - HomeRoute
class HomeRouter: Router<HomeViewController> {
}

// MARK: - HomeRouter: InAppMessageDetailsNavigation
extension HomeRouter: HomeNavigationProtocol {
    
}
