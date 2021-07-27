//
//  Recipe.swift
//  ChefCraftApp
//
//  Created by Work on 27.07.2021.
//

import Foundation

// MARK: - Recipe
struct Recipe {
    let id: String
    let title: String
    let image: String
    let description: String
    let owner: String
    let isLike: Bool
    let stars: Int
    let about: String
    let compositions: [RecipeComposition]
}

extension Recipe: IdentifiableItem {
    var identity: String {
        id
    }
}

extension Recipe: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
