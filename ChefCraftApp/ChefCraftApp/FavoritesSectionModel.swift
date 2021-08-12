//
//  FavoritesSectionModel.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import RxCocoa
import RxSwift
import RxDataSources

struct FavoritesSectionModel {
    var id: String
    var items: [Item]
}

// MARK: - FavoritesSectionModel: AnimatableSectionModelType, IdentifiableType
extension FavoritesSectionModel: AnimatableSectionModelType, IdentifiableType {
    
    typealias Item = FavoriteCellModel
    
    var identity: String {
        return id
    }
    
    init(original: FavoritesSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

// MARK: - FavoritesSectionModel: Equatable
extension FavoritesSectionModel: Equatable {
    
    static func == (lhs: FavoritesSectionModel, rhs: FavoritesSectionModel) -> Bool {
        return lhs.id == rhs.id
    }
}
