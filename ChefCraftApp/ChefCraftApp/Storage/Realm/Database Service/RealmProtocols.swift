//
//  RealmProtocols.swift
//  ChefCraftApp
//
//  Created by Work on 22.07.2021.
//

import RxSwift
import RealmSwift

/// Protocol to managed and connet ViewModel's JSON-codable models & Realm-containered models
protocol DomainStorageProtocol {
        
    func getDomainObject<T: Object & DomainConvertibleType>(by key: Any, realmType: T.Type) -> Single<T.DomainType>
    
    func getDomainObjects<T: Object & DomainConvertibleType>(realmType: T.Type) -> Single<[T.DomainType]>
    
    func getUniqueDomainObject<T: Object & DomainConvertibleType>(realmType: T.Type) -> Single<T.DomainType>
    
    func setDomainObject<T: Object & DomainConvertibleType>(realmType: T.Type, model: T.DomainType) -> Completable
    
    func setDomainObjects<T: Object & DomainConvertibleType>(realmType: T.Type, models: [T.DomainType]) -> Completable
    
    func removeDomainObject<T: Object & DomainConvertibleType>(relmType: T.Type, primaryKey: Int) -> Completable
    
    func removeDomainObject<T: Object & DomainConvertibleType>(relmType: T.Type, primaryKey: String) -> Completable
    
    func removeDomainObjects<T: Object & DomainConvertibleType>(realmType: T.Type, primaryKeys: [Any]) -> Single<[T.DomainType]>
}

/// Protocol to managed and connet ViewModel's Realm-containered models
protocol RealmStorageProtocol {
    
    /// Set Realm Object to Data Base
    ///
    /// - Parameter model: Realm Object to save
    func setRealmObject<T: Object>(realmModel: T) -> Single<T>
    
    /// Delte Realm Object by id
    func deleteRealmObject<T: Object>(realmModel: T) -> Completable
    
    /// Get Array of Realm Objects
    func getRealmObjects<T: Object>(type: T.Type) -> Single<[T]>
    
    /// Get Realm Object by Primary key
    func getRealmObject<T: Object>(type: T.Type, primaryKey: String) -> Single<T>
    
    /// Clean Realm Data Base
    func deleteAllObject()
}
