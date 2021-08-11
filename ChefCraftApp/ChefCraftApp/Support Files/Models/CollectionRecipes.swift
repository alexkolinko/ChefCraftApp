//
//  CollectionRecipes.swift
//  ChefCraftApp
//
//  Created by Work on 27.07.2021.
//

import Foundation

// MARK: - CollectionRecipes
struct CollectionRecipes: Codable {
    let id: String
    let name: String
    let image: String
    let recipes: [Recipe]
}
