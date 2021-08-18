//
//  LocalizationLanguage.swift
//  ChefCraftApp
//
//  Created by Work on 18.08.2021.
//

import Foundation

enum LocalizationLanguage: CaseIterable {
//    case English
    case Ukrainian
    
    var code: String {
        switch self {
//        case .English:
//            return "en"
        case .Ukrainian:
            return "uk"
        }
    }
    
    var localizedName: String {
        switch self {
//        case .English:
//            return "English".localized
        case .Ukrainian:
            return "localization.language.enum.ukranian".localized
        }
    }
    
    var engLocalized: String {
        switch self {
//        case .English:
//            return "English"
        case .Ukrainian:
            return "Ukrainian"
        }
    }
    
    /// returns language in it`s own locale, e.g: German - Deutsch
    var localizedWithSelfLocale: String {
        switch self {
//        case .English:
//            return "localization.language.enum.english".selfLocalized(for: self.code)
        case .Ukrainian:
            return "localization.language.enum.ukranian".selfLocalized(for: self.code)
        }
    }
}

extension LocalizationLanguage {
    
    init(from code: String) {
        switch code {
//        case LocalizationLanguage.English.code:
//            self = LocalizationLanguage.English
        case LocalizationLanguage.Ukrainian.code:
            self = LocalizationLanguage.Ukrainian
        default:
            self = LocalizationLanguage.Ukrainian
        }
    }
    
}
