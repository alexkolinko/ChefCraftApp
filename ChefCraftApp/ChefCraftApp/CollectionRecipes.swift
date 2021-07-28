//
//  CollectionRecipes.swift
//  ChefCraftApp
//
//  Created by Work on 27.07.2021.
//

import Foundation

// MARK: - CollectionRecipes
struct CollectionRecipes {
    let id: String
    let title: String
    let image: String
    let recipes: [RecipeItem]
}

extension CollectionRecipes: IdentifiableItem {
    var identity: String {
        id
    }
}

extension CollectionRecipes: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
