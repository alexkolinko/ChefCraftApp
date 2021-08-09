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
        
        // Register DatabaseChefCraftAllRecipeProvider. New instance created on each 'resolve()'
        container.register(DatabaseChefCraftAllRecipeProvider.self) { resolver -> DatabaseChefCraftAllRecipeProvider in
            return DatabaseChefCraftAllRecipeProvider(storage: resolver.resolve(RealmStorageManager.self)!)
        }.inObjectScope(.transient)
        
        // Register DatabaseChefCraftRecipeProvider. New instance created on each 'resolve()'
        container.register(DatabaseChefCraftRecipeProvider.self) { resolver -> DatabaseChefCraftRecipeProvider in
            return DatabaseChefCraftRecipeProvider(storage: resolver.resolve(RealmStorageManager.self)!)
        }.inObjectScope(.transient)
        
        // Register RealmStorageManager. New instance created on each 'resolve()'
        container.register(RealmStorageManager.self) { _ -> RealmStorageManager in
            return RealmStorageManager()
        }.inObjectScope(.transient)
        
        return container
    }
}
