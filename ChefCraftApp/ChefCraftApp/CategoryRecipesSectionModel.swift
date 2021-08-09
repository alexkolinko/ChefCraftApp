//
//  RecipeItem.swift
//  ChefCraftApp
//
//  Created by Work on 27.07.2021.
//

import RxCocoa
import RxSwift
import RxDataSources

struct CategoryRecipesSectionModel {
    var id: String
    var items: [Item]
}

// MARK: - CategoryRecipesSectionModel: AnimatableSectionModelType, IdentifiableType
extension CategoryRecipesSectionModel: AnimatableSectionModelType, IdentifiableType {
    
    typealias Item = CategoryRecipeCellModel
    
    var identity: String {
        return id
    }
    
    init(original: CategoryRecipesSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

// MARK: - CategoryRecipesSectionModel: Equatable
extension CategoryRecipesSectionModel: Equatable {
    
    static func == (lhs: CategoryRecipesSectionModel, rhs: CategoryRecipesSectionModel) -> Bool {
        return lhs.id == rhs.id
    }
}
