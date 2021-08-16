//
//  DatabaseRecipeProvider.swift
//  ChefCraftApp
//
//  Created by Work on 06.08.2021.
//

import Foundation
import RxCocoa
import RxSwift

// MARK: - DatabaseRecipeProviderProtocol
protocol DatabaseRecipeProviderProtocol {
    /**
     Save current Recipe to Realm Data storage. Actual info you can get from NN
     
     - Returns:
     Return Completable.empty in success cases (it seams that all data successfully saved in local data storage). Return Completable.error(DatabaseError) in cases of fail (it seams that you don't save updates to local data storage and you can retry your operation if you needed)
     */
    func saveRecipe(with model: Recipe) -> Completable
    
    /**
     Get Recipe by id as JSON model from Realm Data Storage.
     
     - Returns:
     Return SingleTrait<Recipe> in success cases(it seams that model existing in local storage and it's not corrupted).
     Return Single.error(DatabaseErorr.objectNotExist) in case of fail(it seams that there're not any model of user -> so you need to get actual info from network request)
     */
    func getRecipe(id: String) -> Single<Recipe>
}

// MARK: - DatabaseRecipeProvider
class DatabaseRecipeProvider {
    private let storage: RealmStorageManager
    
    init(storage: RealmStorageManager) {
        self.storage = storage
    }
}

// MARK: - DatabaseRecipeProvider: DatabaseRecipeProviderProtocol
extension DatabaseRecipeProvider: DatabaseRecipeProviderProtocol {
    
    func saveRecipe(with model: Recipe) -> Completable {
        return self.storage.setDomainObject(realmType: RMRecipe.self, model: model)
    }
    
    func getRecipe(id: String) -> Single<Recipe> {
        return self.storage.getDomainObject(by: id, realmType: RMRecipe.self)
    }
}
