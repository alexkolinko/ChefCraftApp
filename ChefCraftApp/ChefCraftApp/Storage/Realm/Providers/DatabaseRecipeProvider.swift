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
     Save current ChefCraftRecipe to Realm Data storage. Actual info you can get from NN
     
     - Returns:
     Return Completable.empty in success cases (it seams that all data successfully saved in local data storage). Return Completable.error(DatabaseError) in cases of fail (it seams that you don't save updates to local data storage and you can retry your operation if you needed)
     */
    func saveChefCraftRecipe(with model: ChefCraftRecipe) -> Completable
    
    /**
     Get current ChefCraftRecipe as JSON model from Realm Data Storage.
     
     - Returns:
     Return SingleTrait<ChefCraftRecipe> in success cases(it seams that model existing in local storage and it's not corrupted).
     Return Single.error(DatabaseErorr.objectNotExist) in case of fail(it seams that there're not any model of user -> so you need to get actual info from network request)
     */
    func getChefCraftRecipe() -> Single<ChefCraftRecipe>
    
    /**
     Get ChefCraftRecipe by id as JSON model from Realm Data Storage.
     
     - Returns:
     Return SingleTrait<ChefCraftRecipe> in success cases(it seams that model existing in local storage and it's not corrupted).
     Return Single.error(DatabaseErorr.objectNotExist) in case of fail(it seams that there're not any model of user -> so you need to get actual info from network request)
     */
    func getChefCraftRecipe(id: String) -> Single<ChefCraftRecipe>
    
    /**
     Subscribe on current fuel dashboard info, for dynamic handle changes of model. Use it, when you offen comes to View and don't need to user network for data updating.
     
     - Returns:
     Return Observable<ChefCraftRecipe> in success cases(it seams that model existing in local storage and it's not corrupated).
     Return Observable.empty in error cases, because Observable.eror will destroy your binder or subscribtion. Error case seams that your object or not exist, or data base if corrupted.
     */
    func subscribeOnChefCraftRecipe() -> Observable<ChefCraftRecipe>
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
    func saveChefCraftRecipe(with model: ChefCraftRecipe) -> Completable {
        return self.storage.setDomainObject(realmType: RMRecipe.self, model: model)
    }
    
    func getChefCraftRecipe() -> Single<ChefCraftRecipe> {
        return self.storage.getUniqueDomainObject(realmType: RMRecipe.self)
    }
    
    func getChefCraftRecipe(id: String) -> Single<ChefCraftRecipe> {
        return self.storage.getDomainObject(by: id, realmType: RMRecipe.self)
    }
    
    func subscribeOnChefCraftRecipe() -> Observable<ChefCraftRecipe> {
        return self.storage.subscribeOnDomainObjects(realmType: RMRecipe.self).flatMap { objects, _ -> Observable<ChefCraftRecipe>  in
            guard let object = objects.first else {
                return Observable.empty()
            }
            return Observable.of(object)
        }
    }
}
