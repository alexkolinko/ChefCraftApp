//
//  DatabaseRecipeCompositionProvider.swift
//  ChefCraftApp
//
//  Created by Work on 06.08.2021.
//

import Foundation
import RxCocoa
import RxSwift

// MARK: - DatabaseRecipeCompositionProviderProtocol
protocol DatabaseRecipeCompositionProviderProtocol {
    /**
     Save current RecipeComposition to Realm Data storage. Actual info you can get from NN
     
     - Returns:
     Return Completable.empty in success cases (it seams that all data successfully saved in local data storage). Return Completable.error(DatabaseError) in cases of fail (it seams that you don't save updates to local data storage and you can retry your operation if you needed)
     */
    func saveRecipeComposition(with model: RecipeComposition) -> Completable
    
    /**
     Get current RecipeComposition as JSON model from Realm Data Storage.
     
     - Returns:
     Return SingleTrait<RecipeComposition> in success cases(it seams that model existing in local storage and it's not corrupted).
     Return Single.error(DatabaseErorr.objectNotExist) in case of fail(it seams that there're not any model of user -> so you need to get actual info from network request)
     */
    func getRecipeComposition() -> Single<RecipeComposition>
    
    /**
     Subscribe on current fuel dashboard info, for dynamic handle changes of model. Use it, when you offen comes to View and don't need to user network for data updating.
     
     - Returns:
     Return Observable<RecipeComposition> in success cases(it seams that model existing in local storage and it's not corrupated).
     Return Observable.empty in error cases, because Observable.eror will destroy your binder or subscribtion. Error case seams that your object or not exist, or data base if corrupted.
     */
    func subscribeOnRecipeComposition() -> Observable<RecipeComposition>
}

// MARK: - DatabaseRecipeCompositionProvider
class DatabaseRecipeCompositionProvider {
    private let storage: RealmStorageManager
    
    init(storage: RealmStorageManager) {
        self.storage = storage
    }
}

// MARK: - DatabaseRecipeCompositionProvider: DatabaseRecipeCompositionProviderProtocol
extension DatabaseRecipeCompositionProvider: DatabaseRecipeCompositionProviderProtocol {
    func saveRecipeComposition(with model: RecipeComposition) -> Completable {
        return self.storage.setDomainObject(realmType: RMRecipeComposition.self, model: model)
    }
    
    func getRecipeComposition() -> Single<RecipeComposition> {
        return self.storage.getUniqueDomainObject(realmType: RMRecipeComposition.self)
    }
    
    func subscribeOnRecipeComposition() -> Observable<RecipeComposition> {
        return self.storage.subscribeOnDomainObjects(realmType: RMRecipeComposition.self).flatMap { objects, _ -> Observable<RecipeComposition>  in
            guard let object = objects.first else {
                return Observable.empty()
            }
            return Observable.of(object)
        }
    }
}
