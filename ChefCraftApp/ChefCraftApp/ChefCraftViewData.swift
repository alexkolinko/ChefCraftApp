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
    
    struct RecipesCategoriesSection {
        let collectionsRecipes: [CollectionRecipes]
    }
    
    struct MainRecipesSection {
        let recipesHeader: [Recipes]
    }
    
}

// MARK: - ChefCraftOverviewContentBox
enum ChefCraftOverviewContentBox: IdentifiableItem {
    case collectionsRecipesHeader(item: ChefCraftOverviewViewData.RecipesCategoriesSection)
    case recipesHeader(item: ChefCraftOverviewViewData.MainRecipesSection)
    
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
