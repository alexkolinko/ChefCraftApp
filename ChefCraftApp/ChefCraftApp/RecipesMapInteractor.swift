//
//  RecipesMapInteractor.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//  
//

import RxCocoa
import RxSwift

// MARK: - RecipesMapInteractor
/// Abstract logic layer for RecipesMapInteractorImpl
protocol RecipesMapInteractor {
    var recipesData: BehaviorRelay<[Recipe]> { get }
}

// MARK: - RecipesMapInteractorImpl
/// Implementation class for RecipesMapInteractor
final class RecipesMapInteractorImpl {
    
    // - Internal Properties
    let recipesData = BehaviorRelay<[Recipe]>(value: [])
    // - Private Properties
    private let mocked: MockedItem = .init()
    private let disposeBag = DisposeBag()
    
    init() {
        self.recipesData.accept(self.mocked.userRecipes.recipes)
    }
}

// MARK: - RecipesMapInteractorImpl: RecipesMapInteractor
extension RecipesMapInteractorImpl: RecipesMapInteractor {
    
}
