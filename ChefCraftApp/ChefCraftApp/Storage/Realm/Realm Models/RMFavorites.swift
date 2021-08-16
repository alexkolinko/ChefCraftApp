//
//  RMFavorites.swift
//  ChefCraftApp
//
//  Created by Work on 12.08.2021.
//

import RealmSwift


class RMFavorites: Object {
    /// Favoreite id
    @objc dynamic var id: String = "favoreites"
    /// List of recipes
    var favoreiteRecipes: List<String> = List<String>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func customInit(from domain: Favorites) {
        self.favoreiteRecipes.append(objectsIn: domain.recipes)
    }
}

// MARK: - RMFavorites: DomainConvertibleType
extension RMFavorites: DomainConvertibleType {
    
    typealias DomainType = Favorites
    
    func asDomain() -> Favorites {
        let recipes = Array(self.favoreiteRecipes)
        let model = Favorites(recipes: recipes)
        return model
    }
    
    func fromDomain(domain: Favorites) {
        self.customInit(from: domain)
    }
}
