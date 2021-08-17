//
//  Recipe.swift
//  ChefCraftApp
//
//  Created by Work on 27.07.2021.
//

import Foundation

// MARK: - Recipe
struct Recipe: Codable {
    let id: String
    let name: String
    let image: String
    let description: String
    let owner: String
    let isLike: Bool
    var stars: Int
    let about: String
    let compositions: [RecipeComposition]
}
