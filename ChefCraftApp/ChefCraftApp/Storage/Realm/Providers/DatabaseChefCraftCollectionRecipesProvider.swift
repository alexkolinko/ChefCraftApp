//
//  DatabaseChefCraftCollectionRecipesProvider.swift
//  ChefCraftApp
//
//  Created by Work on 06.08.2021.
//

import Foundation
import RxCocoa
import RxSwift

// MARK: - DatabaseChefCraftCollectionRecipesProviderProtocol
protocol DatabaseChefCraftCollectionRecipesProviderProtocol {
    /**
     Save current ChefCraftCollectionRecipes to Realm Data storage. Actual info you can get from NN
     
     - Returns:
     Return Completable.empty in success cases (it seams that all data successfully saved in local data storage). Return Completable.error(DatabaseError) in cases of fail (it seams that you don't save updates to local data storage and you can retry your operation if you needed)
     */
    func saveChefCraftCollectionRecipes(with model: ChefCraftCollectionRecipes) -> Completable
    
    /**
     Get current ChefCraftCollectionRecipes as JSON model from Realm Data Storage.
     
     - Returns:
     Return SingleTrait<ChefCraftCollectionRecipes> in success cases(it seams that model existing in local storage and it's not corrupted).
     Return Single.error(DatabaseErorr.objectNotExist) in case of fail(it seams that there're not any model of user -> so you need to get actual info from network request)
     */
    func getChefCraftCollectionRecipes() -> Single<ChefCraftCollectionRecipes>
    
    /**
     Subscribe on current fuel dashboard info, for dynamic handle changes of model. Use it, when you offen comes to View and don't need to user network for data updating.
     
     - Returns:
     Return Observable<ChefCraftCollectionRecipes> in success cases(it seams that model existing in local storage and it's not corrupated).
     Return Observable.empty in error cases, because Observable.eror will destroy your binder or subscribtion. Error case seams that your object or not exist, or data base if corrupted.
     */
    func subscribeOnChefCraftCollectionRecipes() -> Observable<ChefCraftCollectionRecipes>
}

// MARK: - DatabaseChefCraftAllRecipeProvider
class DatabaseChefCraftCollectionRecipesProvider {
    private let storage: RealmStorageManager
    
    init(storage: RealmStorageManager) {
        self.storage = storage
    }
}

// MARK: - DatabaseChefCraftCollectionRecipesProvider: DatabaseChefCraftCollectionRecipesProviderProtocol
extension DatabaseChefCraftCollectionRecipesProvider: DatabaseChefCraftCollectionRecipesProviderProtocol {
    func saveChefCraftCollectionRecipes(with model: ChefCraftCollectionRecipes) -> Completable {
        return self.storage.setDomainObject(realmType: RMChefCraftCollectionRecipes.self, model: model)
    }
    
    func getChefCraftCollectionRecipes() -> Single<ChefCraftCollectionRecipes> {
        return self.storage.getUniqueDomainObject(realmType: RMChefCraftCollectionRecipes.self)
    }
    
    func subscribeOnChefCraftCollectionRecipes() -> Observable<ChefCraftCollectionRecipes> {
        return self.storage.subscribeOnDomainObjects(realmType: RMChefCraftCollectionRecipes.self).flatMap { objects, _ -> Observable<ChefCraftCollectionRecipes>  in
            guard let object = objects.first else {
                return Observable.empty()
            }
            return Observable.of(object)
        }
    }
}
