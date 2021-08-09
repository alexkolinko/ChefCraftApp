//
//  RMChefCraftAllRecipes.swift
//  ChefCraftApp
//
//  Created by Work on 06.08.2021.
//

import Foundation
import RealmSwift

final class RMChefCraftAllRecipes: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var collectionsRecipes = Data()
    @objc dynamic var recipes = Data()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func customInit(from domain: ChefCraftAllRecipes) {
        self.id = domain.id
        
        let encoder = JSONEncoder()
        
        if let collectionsRecipes = try? encoder.encode(domain.collectionsRecipes) {
            self.collectionsRecipes = collectionsRecipes
        }
        
        if let recipes = try? encoder.encode(domain.recipes) {
            self.recipes = recipes
        }
    }
}

extension RMChefCraftAllRecipes: DomainConvertibleType {
    func asDomain() -> ChefCraftAllRecipes {
        
        let decoder = JSONDecoder()
        let collectionsRecipes = (try? decoder.decode([ChefCraftCollectionRecipes].self, from: self.collectionsRecipes)) ?? []
        let recipes = (try? decoder.decode([ChefCraftRecipe].self, from: self.recipes)) ?? []
        return ChefCraftAllRecipes(id: self.id, collectionsRecipes: collectionsRecipes, recipes: recipes)
    }
    
    func fromDomain(domain: ChefCraftAllRecipes) {
        customInit(from: domain)
    }
}
