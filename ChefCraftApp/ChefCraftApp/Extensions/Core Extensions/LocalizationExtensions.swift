//
//  LocalizationExtensions.swift
//  ChefCraftApp
//
//  Created by Work on 18.08.2021.
//


import Foundation
import SwiftyUserDefaults

extension String {
    
    var localized: String {
        if let currentLanguageCode = Defaults.userSelectedLanguageCode,
            let path = Bundle.main.path(forResource: currentLanguageCode, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        } else {
            return NSLocalizedString(self, comment: "")
        }
    }
    
    var uplocalized: String {
        return self.localized.uppercased()
    }
    
    func selfLocalized(for lang: String) -> String {
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        } else {
            return NSLocalizedString(self, comment: "")
        }
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
