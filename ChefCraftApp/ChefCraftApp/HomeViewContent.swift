//
//  HomeViewContent.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import RxDataSources
import UIKit

// MARK: - HomeViewContent
struct HomeViewContent: Equatable {
    let id: String
    let previewId: String
    let sectionModel: AnimatableSection<HomeOverviewContentBox>
    
    struct CategoriesSection {
        let collectionsRecipes: [CollectionRecipes]
    }
    
    struct RecipesSection {
        let recipesHeader: [Recipe]
    }
    
}

// MARK: - HomeOverviewContentBox
enum HomeOverviewContentBox: IdentifiableItem {
    case categories(item: HomeViewContent.CategoriesSection)
    case recipes(item: HomeViewContent.RecipesSection)
    
    func calculateItemSize(width: CGFloat) -> CGSize {
        switch self {
        case .categories:
            let height = CGFloat(190)
            return CGSize(width: width, height: height)
        case .recipes:
            let height = CGFloat(350)
            return CGSize(width: width, height: height)
        }
    }
}

extension HomeOverviewContentBox {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identity == rhs.identity
    }
}
