//
//  RMChefCraftCollectionRecipes.swift
//  ChefCraftApp
//
//  Created by Work on 06.08.2021.
//

import Foundation
import RealmSwift

final class RMChefCraftCollectionRecipes: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var recipes = Data()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func customInit(from domain: ChefCraftCollectionRecipes) {
        self.id = domain.id
        self.name = domain.name
        self.image = domain.image
        
        let encoder = JSONEncoder()
        
        if let recipes = try? encoder.encode(domain.recipes) {
            self.recipes = recipes
        }
    }
}

extension RMChefCraftCollectionRecipes: DomainConvertibleType {
    func asDomain() -> ChefCraftCollectionRecipes {
        
        let decoder = JSONDecoder()
        let recipes = (try? decoder.decode([ChefCraftRecipe].self, from: self.recipes)) ?? []
        return ChefCraftCollectionRecipes(id: self.id, name: self.name, image: self.image, recipes: recipes)
    }
    
    func fromDomain(domain: ChefCraftCollectionRecipes) {
        customInit(from: domain)
    }
}

