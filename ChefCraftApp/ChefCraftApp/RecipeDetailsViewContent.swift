//
//  RecipeDetailsViewContent.swift
//  ChefCraftApp
//
//  Created by Work on 30.07.2021.
//

import RxDataSources
import UIKit

struct RecipeDetailsViewContent: Equatable {
    let id: String
    
    let sectionModel: AnimatableSection<RecipeDetailsOverviewContentBox>
    
    struct HeaderSection {
        let id: String
        let title: String
        let owner: String
        let stars: Int
        let isLike: Bool
        let cooked: Bool
    }
    
    struct CompositionsSection {
        let compositions: [CompositionCellItem]
    }
    
    struct AboutSection {
        let about: String
    }
    
    
    struct CompositionCellItem {
        let id: String
        let type: RecipeCompositionType
        let value: Int
    }
}

// MARK: - RecipeDetailsOverviewContentBox: IdentifiableItem
enum RecipeDetailsOverviewContentBox: IdentifiableItem {
    case header(item: RecipeDetailsViewContent.HeaderSection)
    case compositions(item: RecipeDetailsViewContent.CompositionsSection)
    case about(item: RecipeDetailsViewContent.AboutSection)

    func calculateItemSize(width: CGFloat) -> CGSize {
        switch self {
        case .header:
            let height = CGFloat(150)
            return CGSize(width: width, height: height)
        case .compositions:
            let height = CGFloat(80)
            return CGSize(width: width, height: height)
        case .about:
            let height = CGFloat(150)
            return CGSize(width: width, height: height)
        }
    }
}

// MARK: - RecipeDetailsOverviewContentBox
extension RecipeDetailsOverviewContentBox {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identity == rhs.identity
    }
}

// MARK: - RecipeDetailsViewContent.HeaderSection: IdentifiableItem
extension RecipeDetailsViewContent.HeaderSection: IdentifiableItem {
    var identity: String {
        id
    }
}

// MARK: - RecipeDetailsViewContent.CompositionCellItem: IdentifiableItem
extension RecipeDetailsViewContent.CompositionCellItem: IdentifiableItem {
    var identity: String {
        id
    }
}

// MARK: - RecipeDetailsViewContent.HeaderSection: Equatable
extension RecipeDetailsViewContent.HeaderSection: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - RecipeDetailsViewContent.CompositionCellItem: Equatable
extension RecipeDetailsViewContent.CompositionCellItem: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
