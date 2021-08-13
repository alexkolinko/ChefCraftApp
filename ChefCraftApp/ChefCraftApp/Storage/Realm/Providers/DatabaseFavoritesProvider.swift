//
//  DatabaseFavoritesProvider.swift
//  ChefCraftApp
//
//  Created by Work on 12.08.2021.
//

import Foundation
import RxCocoa
import RxSwift

// MARK: - DatabaseFavoritesProviderProtocol
protocol DatabaseFavoritesProviderProtocol {
    /**
     Save current Favorites to Realm Data storage. Actual info you can get from NN
     
     - Returns:
     Return Completable.empty in success cases (it seams that all data successfully saved in local data storage). Return Completable.error(DatabaseError) in cases of fail (it seams that you don't save updates to local data storage and you can retry your operation if you needed)
     */
    func saveFavorites(with model: Favorites) -> Completable
    
    /**
     Get current Favorites as JSON model from Realm Data Storage.
     
     - Returns:
     Return SingleTrait<Favorites> in success cases(it seams that model existing in local storage and it's not corrupted).
     Return Single.error(DatabaseErorr.objectNotExist) in case of fail(it seams that there're not any model of user -> so you need to get actual info from network request)
     */
    func getFavorites() -> Single<Favorites>
    
    /**
     Get Favorites by id as JSON model from Realm Data Storage.
     
     - Returns:
     Return SingleTrait<Favorites> in success cases(it seams that model existing in local storage and it's not corrupted).
     Return Single.error(DatabaseErorr.objectNotExist) in case of fail(it seams that there're not any model of user -> so you need to get actual info from network request)
     */
    func getFavorites(id: String) -> Single<Favorites>
    
    /**
     Subscribe on favorites, for dynamic handle changes of model. Use it, when you offen comes to View and don't need to user network for data updating.
     
     - Returns:
     Return Observable<Favorites> in success cases(it seams that model existing in local storage and it's not corrupated).
     Return Observable.empty in error cases, because Observable.eror will destroy your binder or subscribtion. Error case seams that your object or not exist, or data base if corrupted.
     */
    func subscribeOnFavorites() -> Observable<Favorites>
}

// MARK: - DatabaseFavoritesProvider
class DatabaseFavoritesProvider {
    private let storage: RealmStorageManager
    
    init(storage: RealmStorageManager) {
        self.storage = storage
    }
}

// MARK: - DatabaseFavoritesProvider: DatabaseRecipeProviderProtocol
extension DatabaseFavoritesProvider: DatabaseFavoritesProviderProtocol {
    func saveFavorites(with model: Favorites) -> Completable {
        return self.storage.setDomainObject(realmType: RMFavorites.self, model: model)
    }
    
    func getFavorites() -> Single<Favorites> {
        return self.storage.getUniqueDomainObject(realmType: RMFavorites.self)
    }
    
    func getFavorites(id: String) -> Single<Favorites> {
        return self.storage.getDomainObject(by: id, realmType: RMFavorites.self)
    }
    
    func subscribeOnFavorites() -> Observable<Favorites> {
        return self.storage.subscribeOnDomainObjects(realmType: RMFavorites.self).flatMap { objects, _ -> Observable<Favorites>  in
            guard let object = objects.first else {
                return Observable.empty()
            }
            return Observable.of(object)
        }
    }
}
