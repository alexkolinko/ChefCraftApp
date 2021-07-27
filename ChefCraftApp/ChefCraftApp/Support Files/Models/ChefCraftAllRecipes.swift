//
//  ChefCraftAllRecipes.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import Foundation

struct ChefCraftAllRecipes: Decodable {
    let id: String
    let collectionsRecipes: [ChefCraftCollectionRecipes]
    let recipes: [ChefCraftRecipe]
    
    init(
        id: String,
        collectionsRecipes: [ChefCraftCollectionRecipes],
        recipes: [ChefCraftRecipe]
    ) {
        self.id = id
        self.collectionsRecipes = collectionsRecipes
        self.recipes = recipes
    }
}

extension ChefCraftAllRecipes: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

extension ChefCraftAllRecipes {
    /// For use in mocks
    static var `default`: Self {
        ChefCraftAllRecipes(id: "", collectionsRecipes: [], recipes: [])
    }
}
