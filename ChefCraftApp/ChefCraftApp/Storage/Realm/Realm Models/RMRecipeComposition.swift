//
//  RMRecipeComposition.swift
//  ChefCraftApp
//
//  Created by Work on 06.08.2021.
//

import Foundation
import RealmSwift

final class RMRecipeComposition: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var value: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func customInit(from domain: RecipeComposition) {
        self.type = domain.type.rawValue
        self.value = domain.value
    }
}

extension RMRecipeComposition: DomainConvertibleType {
    func asDomain() -> RecipeComposition {
        return RecipeComposition(type: RecipeCompositionType(rawValue: self.type) ?? .calories, value: self.value)
    }
    
    func fromDomain(domain: RecipeComposition) {
        customInit(from: domain)
    }
}

