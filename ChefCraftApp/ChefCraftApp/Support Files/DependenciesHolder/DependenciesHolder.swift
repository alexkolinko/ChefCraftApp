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
        
        return container
    }
}
