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
}

extension CollectionRecipes: IdentifiableItem {
    var identity: String {
        id
    }
}
