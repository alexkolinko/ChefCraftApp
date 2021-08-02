//
//  RecipeHeaderSectionModel.swift
//  ChefCraftApp
//
//  Created by Work on 02.08.2021.
//

import Foundation

struct RecipeHeaderSectionModel {
    let id: String
    let title: String
    let owner: String
    let stars: Int
}

extension RecipeHeaderSectionModel: IdentifiableItem {
    var identity: String {
        id
    }
}

extension RecipeHeaderSectionModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
