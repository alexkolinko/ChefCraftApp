//
//  UserProgressService+Models.swift
//  ChefCraftApp
//
//  Created by Work on 13.12.2021.
//

import RxSwift
import MapKit
 
// MARK: - UserProgressService + Input
extension UserProgressService {
    
    struct Input {
        let mockedRecipes: AnyObserver<[Recipe]>
        let recipes: AnyObserver<[Recipe]>
    }
}

// MARK: - UserProgressService + Output
extension UserProgressService {
    
    struct Output {
        let result: Observable<Result>
        
        /// UI response DTO for service output stream
        struct Result {
            let cookedRecipesPerDay: Int
            let cookedRecipesPerWeek: Int
            let missedRecipes: Int
            let needToBeCook: Int
        }
    }
}
