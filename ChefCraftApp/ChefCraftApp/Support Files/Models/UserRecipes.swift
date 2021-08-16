//
//  UserRecipes.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import Foundation

struct UserRecipes: Decodable {
    let id: String
    let categoriesRecipes: [CategoryRecipes]
    let recipes: [Recipe]
    
    init(
        id: String,
        categoriesRecipes: [CategoryRecipes],
        recipes: [Recipe]
    ) {
        self.id = id
        self.categoriesRecipes = categoriesRecipes
        self.recipes = recipes
    }
}

extension UserRecipes: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

extension UserRecipes {
    /// For use in mocks
    static var `default`: Self {
        UserRecipes(id: "", categoriesRecipes: [], recipes: [])
    }
}
