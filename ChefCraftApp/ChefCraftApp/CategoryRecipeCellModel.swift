//
//  CategoryRecipeCellModel.swift
//  ChefCraftApp
//
//  Created by Work on 04.08.2021.
//

import RxDataSources
import UIKit

// MARK: - CategoryRecipeCellModel
struct CategoryRecipeCellModel: IdentifiableType {
    /// JSON model of Recipe
    var model: Recipe
    
    var identity: String {
        return "\(model.id)"
    }
}

// MARK: - CategoryRecipeCellModel: Equatable
extension CategoryRecipeCellModel: Equatable {
    
    static func == (lhs: CategoryRecipeCellModel, rhs: CategoryRecipeCellModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
