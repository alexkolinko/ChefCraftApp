//
//  RecipeDetailsRouter.swift
//  ChefCraftApp
//
//  Created by Work on 29.07.2021.
//

import Foundation
import UIKit

// MARK: - InAppPostsFilterNavigation
protocol RecipeDetailsNavigation {
    
//    /// Open inputed link in UIApplication default browser
//    func showUrl(_ url: URL)
//
//    /// Close View message details screen
//    func closeView()
    
    /// Pop to pre screen from posts filter screen
    func popView()
}

// MARK: - RecipeDetailsRouter: Router<RecipeDetailsViewController>
class RecipeDetailsRouter: Router<RecipeDetailsViewController> {
}

// MARK: - RecipeDetailsRouter: RecipeDetailsNavigation
extension RecipeDetailsRouter: RecipeDetailsNavigation {
    
    func popView() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
