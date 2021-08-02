//
//  RecipeCompositionCellModel.swift
//  ChefCraftApp
//
//  Created by Work on 02.08.2021.
//

import Foundation

struct RecipeCompositionCellModel {
    let id: String
    let type: RecipeCompositionType
    let value: Int
}

extension RecipeCompositionCellModel: IdentifiableItem {
    var identity: String {
        id
    }
}

extension RecipeCompositionCellModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
