//
//  ChefCraftViewData.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import RxDataSources
import UIKit

// MARK: - ChefCraftOverviewViewData
struct ChefCraftOverviewViewData: Equatable {
    let id: String
    let previewId: String
    let sectionModel: AnimatableSection<ChefCraftOverviewContentBox>
    
    struct CollectionsRecipesHeader {
        let collectionsRecipes: [CollectionRecipes]
    }
    
    struct CollectionRecipes {
        let id: String
        let title: String
    }
    
    struct RecipesHeader {
        let recipesHeader: [Recipes]
    }
    
    struct Recipes {
        let id: String
        let title: String
        let description: String
    }
    
}

// MARK: - ChefCraftOverviewContentBox
enum ChefCraftOverviewContentBox: IdentifiableItem {
    case collectionsRecipesHeader(item: ChefCraftOverviewViewData.CollectionsRecipesHeader)
    case recipesHeader(item: ChefCraftOverviewViewData.RecipesHeader)
    
    func calculateItemSize(width: CGFloat) -> CGSize {
        switch self {
        case .collectionsRecipesHeader:
            let height = CGFloat(190)
            return CGSize(width: width, height: height)
        case .recipesHeader:
            let height = CGFloat(350)
            return CGSize(width: width, height: height)
        }
    }
}

extension ChefCraftOverviewContentBox {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identity == rhs.identity
    }
}

extension ChefCraftOverviewViewData.CollectionRecipes: IdentifiableItem {
    var identity: String {
        id
    }
}

extension ChefCraftOverviewViewData.Recipes: IdentifiableItem {
    var identity: String {
        id
    }
}
