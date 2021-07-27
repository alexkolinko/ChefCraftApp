//
//  ChefCraftCollectionRecipes.swift
//  ChefCraftApp
//
//  Created by Work on 27.07.2021.
//

import Foundation

// MARK: - ChefCraftCollectionRecipes
struct ChefCraftCollectionRecipes: Codable {
    let id: String
    let name: String
    let image: String
    let recipes: [RecipeItem]
}
