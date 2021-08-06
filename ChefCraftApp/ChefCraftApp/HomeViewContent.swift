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
        let categories: [CategoryCellItem]
    }
    
    struct RecipesSection {
        let recipes: [RecipeCellItem]
    }
    
    struct CategoryCellItem {
        let id: String
        let title: String
        let image: String
        let recipes: [RecipeItem]
    }
    
    struct RecipeCellItem {
        let id: String
        let title: String
        let image: String
        let description: String
        let owner: String
        let isLike: Bool
        let stars: Int
        let about: String
        let compositions: [RecipeComposition]
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

extension HomeViewContent.CategoryCellItem: IdentifiableItem {
    var identity: String {
        id
    }
}

extension HomeViewContent.RecipeCellItem: IdentifiableItem {
    var identity: String {
        id
    }
}

extension HomeViewContent.CategoryCellItem: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

extension HomeViewContent.RecipeCellItem: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
