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
        let cookedRecipesPerDay: Observable<Int>
        let cookedRecipesPerWeek: Observable<Int>
        let missedRecipes: Observable<Int>
        let needToBeCook: Observable<Int>
    }
}
