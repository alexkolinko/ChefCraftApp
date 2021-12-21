//
//  ProgressUserModel.swift
//  ChefCraftApp
//
//  Created by Work on 20.12.2021.
//

import Foundation

extension ProfilePresenterImpl {
    struct ProgressUserModel {
        let cookedRecipesPerDay: Int
        let cookedRecipesPerWeek: Int
        let missedRecipes: Int
        let needToBeCook: Int
    }
}
