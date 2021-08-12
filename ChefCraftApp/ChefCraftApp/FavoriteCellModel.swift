//
//  FavoriteCellModel.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import RxDataSources
import UIKit

// MARK: - FavoriteCellModel
struct FavoriteCellModel: IdentifiableType {
    /// JSON model of Recipe
    var model: Recipe
    
    var identity: String {
        return "\(model.id)"
    }
}

// MARK: - FavoriteCellModel: Equatable
extension FavoriteCellModel: Equatable {
    
    static func == (lhs: FavoriteCellModel, rhs: FavoriteCellModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
