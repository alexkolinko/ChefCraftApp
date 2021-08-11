//
//  RootRouter.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import Foundation
import UIKit

typealias RootRouterRoutes = HomeRoute & RecipeDetailsRoute

// MARK: - RootNavigationProtocol
protocol RootNavigationProtocol {
    
}

// MARK: - RootRouter: Router<RootViewController>
class RootRouter: Router<RootViewController>, RootRouterRoutes {
    var HomeTransition: Transition {
        return RootTransition()
    }
    
    var RecipeDetailsTransition: Transition {
        return RootTransition()
    }
}

// MARK: - RootRouter: RootNavigationProtocol
extension RootRouter: RootNavigationProtocol {
  
}
