//
//  DefaultsKeys.swift
//  ChefCraftApp
//
//  Created by Work on 18.08.2021.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {

    // -- App's needs keys
    var userSelectedLanguageCode: DefaultsKey<String?> { .init("userSelectedLanguageCode") }
    var appleLanguages: DefaultsKey<[String]> { .init("AppleLanguages", defaultValue: ["Base"]) }
}
