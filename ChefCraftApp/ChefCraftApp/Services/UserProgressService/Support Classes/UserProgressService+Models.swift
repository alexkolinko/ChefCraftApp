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
        
        let recipes: AnyObserver<[Recipe]>
    }
}

// MARK: - UserProgressService + Output
extension UserProgressService {
    
    struct Output {
        let cookedRecipes: Observable<Int>
    }
    

}
