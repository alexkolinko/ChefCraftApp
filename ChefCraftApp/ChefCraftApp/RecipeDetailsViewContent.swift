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

// MARK: - RecipeDetailsOverviewContentBox
enum RecipeDetailsOverviewContentBox: IdentifiableItem {
    case header(item: RecipeDetailsViewContent.HeaderSection)
    case compositions(item: RecipeDetailsViewContent.CompositionsSection)
    case about(item: RecipeDetailsViewContent.AboutSection)

    func calculateItemSize(width: CGFloat) -> CGSize {
        switch self {
        case .header:
            let height = CGFloat(100)
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

extension RecipeDetailsOverviewContentBox {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identity == rhs.identity
    }
}

extension RecipeDetailsViewContent.HeaderSection: IdentifiableItem {
    var identity: String {
        id
    }
}

extension RecipeDetailsViewContent.CompositionCellItem: IdentifiableItem {
    var identity: String {
        id
    }
}

extension RecipeDetailsViewContent.HeaderSection: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

extension RecipeDetailsViewContent.CompositionCellItem: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

