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

// MARK: - CollectionRecipes
struct ChefCraftCollectionRecipes: Codable {
    let id: String
    let name: String
}

// MARK: - CollectionRecipes
struct ChefCraftRecipe: Codable {
    let id: String
    let name: String
    let description: String
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
