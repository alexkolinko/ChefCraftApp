//
//  RecipeViewData.swift
//  ChefCraftApp
//
//  Created by Work on 30.07.2021.
//

import RxDataSources
import UIKit

struct RecipeOwerViewData: Equatable {
    let id: String
    
    let sectionModel: AnimatableSection<RecipeOverviewContentBox>
    
    struct RecipeHeaderSection {
        var model: RecipeHeaderSectionModel
    }
    
    struct RecipeCompositionsSection {
        let compositions: [RecipeCompositionCellModel]
    }
    
    struct RecipeAboutSection {
        let about: String
    }
}

// MARK: - RecipeOverviewContentBox
enum RecipeOverviewContentBox: IdentifiableItem {
    case recipeHeader(item: RecipeOwerViewData.RecipeHeaderSection)
    case recipeCompositionsHeader(item: RecipeOwerViewData.RecipeCompositionsSection)
    case recipeAboutHeader(item: RecipeOwerViewData.RecipeAboutSection)

    func calculateItemSize(width: CGFloat) -> CGSize {
        switch self {
        case .recipeHeader:
            let height = CGFloat(100)
            return CGSize(width: width, height: height)
        case .recipeCompositionsHeader:
            let height = CGFloat(80)
            return CGSize(width: width, height: height)
        case .recipeAboutHeader:
            let height = CGFloat(150)
            return CGSize(width: width, height: height)
        }
    }
}

extension RecipeOverviewContentBox {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identity == rhs.identity
    }
}

