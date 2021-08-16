//
//  DependenciesHolder.swift
//  ChefCraftApp
//
//  Created by Work on 22.07.2021.
//

import Foundation
import Swinject

class DependenciesHolder {
    
    func injector() -> Container {
        let container = Container()
        
        let migrationService = RealmMigrationService()
        migrationService.performMigration()
        
        //
        // MARK: - SINGLETON INJECTS
        //
        
        // Register DatabaseFavoritesProvider. New instance created on each 'resolve()'
        container.register(DatabaseFavoritesProvider.self) { resolver -> DatabaseFavoritesProvider in
            return DatabaseFavoritesProvider(storage: resolver.resolve(RealmStorageManager.self)!)
        }.inObjectScope(.transient)
        
        // Register DatabaseRecipeProvider. New instance created on each 'resolve()'
        container.register(DatabaseRecipeProvider.self) { resolver -> DatabaseRecipeProvider in
            return DatabaseRecipeProvider(storage: resolver.resolve(RealmStorageManager.self)!)
        }.inObjectScope(.transient)
        
        // Register RealmStorageManager. New instance created on each 'resolve()'
        container.register(RealmStorageManager.self) { _ -> RealmStorageManager in
            return RealmStorageManager()
        }.inObjectScope(.transient)
        
        return container
    }
}
