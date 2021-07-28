//
//  ChefCraftRecipe.swift
//  ChefCraftApp
//
//  Created by Work on 27.07.2021.
//

import Foundation

// MARK: - ChefCraftRecipe
struct ChefCraftRecipe: Codable {
    let id: String
    let name: String
    let image: String
    let description: String
    let owner: String
    let isLike: Bool
    let stars: Int
    let about: String
    let compositions: [RecipeComposition]
}
