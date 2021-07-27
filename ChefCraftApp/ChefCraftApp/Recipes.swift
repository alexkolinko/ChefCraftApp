//
//  Recipes.swift
//  ChefCraftApp
//
//  Created by Work on 27.07.2021.
//

import Foundation

// MARK: - Recipes
struct Recipes {
    let id: String
    let title: String
    let description: String
}

extension Recipes: IdentifiableItem {
    var identity: String {
        id
    }
}
