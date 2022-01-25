//
//  RMRecipe.swift
//  ChefCraftApp
//
//  Created by Work on 06.08.2021.
//

import Foundation
import RealmSwift

final class RMRecipe: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var descriptionRecipe: String = ""
    @objc dynamic var owner: String = ""
    @objc dynamic var isLike: Bool = false
    @objc dynamic var cooked: Bool = false
    @objc dynamic var dateOfCooked: String = ""
    @objc dynamic var stars: Int = 0
    @objc dynamic var about: String = ""
    @objc dynamic var latitude: Float = 0.0
    @objc dynamic var longitude: Float = 0.0
    @objc dynamic var compositions = Data()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func customInit(from domain: Recipe) {
        self.id = domain.id
        self.name = domain.name
        self.image = domain.image
        self.descriptionRecipe = domain.description
        self.owner = domain.owner
        self.isLike = domain.isLike
        self.cooked = domain.cooked
        self.dateOfCooked = domain.dateOfCooked
        self.stars = domain.stars
        self.about = domain.about
        
        let encoder = JSONEncoder()
        
        if let compositions = try? encoder.encode(domain.compositions) {
            self.compositions = compositions
        }
    }
}

extension RMRecipe: DomainConvertibleType {
    func asDomain() -> Recipe {
        
        let decoder = JSONDecoder()
        let compositions = (try? decoder.decode([RecipeComposition].self, from: self.compositions)) ?? []
        return Recipe(
            id: self.id,
            name: self.name,
            image: self.image,
            description: self.descriptionRecipe,
            owner: self.owner,
            isLike: self.isLike,
            cooked: self.cooked,
            dateOfCooked: self.dateOfCooked,
            stars: self.stars,
            about: self.about,
            compositions: compositions
        )
    }
    
    func fromDomain(domain: Recipe) {
        customInit(from: domain)
    }
}

