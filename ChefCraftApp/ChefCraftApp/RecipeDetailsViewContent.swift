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
        var model: RecipeHeaderSectionModel
    }
    
    struct CompositionsSection {
        let compositions: [RecipeCompositionCellModel]
    }
    
    struct AboutSection {
        let about: String
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

