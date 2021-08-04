//
//  CategoryRecipesRouter.swift
//  shell
//
//  Created by Work on 04.08.2021.
//  Copyright © 2021 CoreTeka. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CategoryRecipesNavigation
/// Abstract navigation layer for CategoryRecipesRouter
protocol CategoryRecipesNavigation {
    
//    /// Open inputed link in UIApplication default browser
//    func showUrl(_ url: URL)
//
//    /// Close View message details screen
//    func closeView()
    
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
