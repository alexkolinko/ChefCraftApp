//
//  RecipeCompositionType.swift
//  ChefCraftApp
//
//  Created by Work on 27.07.2021.
//

import Foundation

// MARK: - RecipeCompositionType
enum RecipeCompositionType: String, Codable {
    case calories
    case ingredients
    case totalTime
    
    var title: String {
        switch self {
        case .calories:
            return "Calories"
        case .ingredients:
            return "Ingredients"
        case .totalTime:
            return "Total Time"
        }
    }
    
    var unit: String {
        switch self {
        case .calories:
            return "cal"
        case .totalTime:
            return "min"
        default:
            return ""
        }
    }
}
