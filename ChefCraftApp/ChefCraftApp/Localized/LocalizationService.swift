//
//  LocalizationService.swift
//  ChefCraftApp
//
//  Created by Work on 18.08.2021.
//

import Foundation
import SwiftyUserDefaults
import RxSwift

final class LocalizationService {
    
    init() {
        loadDefaultLanguage()
    }
    
    func loadDefaultLanguage() {
        if Defaults.userSelectedLanguageCode == nil {
            if let deviceLanguageCode = Locale.current.languageCode {
                switch deviceLanguageCode {
                case LocalizationLanguage.Ukrainian.code:
                    Defaults.userSelectedLanguageCode = LocalizationLanguage.Ukrainian.code
//                case LocalizationLanguage.English.code:
//                    Defaults[.userSelectedLanguageCode] = LocalizationLanguage.English.code
                default:
                    Defaults.userSelectedLanguageCode = LocalizationLanguage.Ukrainian.code
                }
            } else {
                Defaults.userSelectedLanguageCode = LocalizationLanguage.Ukrainian.code
            }
        }
    }
    
    func set(language: LocalizationLanguage) {
        Defaults.userSelectedLanguageCode = language.code
        Defaults.appleLanguages = [language.code]
    }
    
    func getCurrentLanguage() -> LocalizationLanguage {
        if let currentCode = Defaults.userSelectedLanguageCode {
            return LocalizationLanguage(from: currentCode)
        } else {
            return LocalizationLanguage.Ukrainian
        }
    }
}
