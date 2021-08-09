//
//  CategoryRecipesRouter.swift
//  ChefCraftApp
//
//  Created by Work on 04.08.2021.
//

import Foundation
import UIKit

// MARK: - CategoryRecipesNavigation
/// Abstract navigation layer for CategoryRecipesRouter
protocol CategoryRecipesNavigation {
    
    /// Pop to pre screen from posts filter screen
    func popView()
}

// MARK: - CategoryRecipesRoute
class CategoryRecipesRouter: Router<CategoryRecipesViewController> {
}

extension CategoryRecipesRouter: CategoryRecipesNavigation {
    
    func popView() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
