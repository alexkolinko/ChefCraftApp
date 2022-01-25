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
    var restaurantsData: BehaviorRelay<[Restaurant]> { get }
}

// MARK: - RecipesMapInteractorImpl
/// Implementation class for RecipesMapInteractor
final class RecipesMapInteractorImpl {
    
    // - Internal Properties
    let restaurantsData = BehaviorRelay<[Restaurant]>(value: [])
    // - Private Properties
    private let mocked: MockedItem = .init()
    private let disposeBag = DisposeBag()
    
    init() {
        self.restaurantsData.accept(self.mocked.restaurants)
    }
}

// MARK: - RecipesMapInteractorImpl: RecipesMapInteractor
extension RecipesMapInteractorImpl: RecipesMapInteractor {
    
}
