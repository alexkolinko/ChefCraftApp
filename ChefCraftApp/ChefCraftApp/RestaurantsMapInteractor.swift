//
//  RestaurantsMapInteractor.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//  
//

import RxCocoa
import RxSwift

// MARK: - RestaurantsMapInteractor
/// Abstract logic layer for RestaurantsMapInteractorImpl
protocol RestaurantsMapInteractor {
    var restaurantsData: BehaviorRelay<[Restaurant]> { get }
}

// MARK: - RestaurantsMapInteractorImpl
/// Implementation class for RestaurantsMapInteractor
final class RestaurantsMapInteractorImpl {
    
    // - Internal Properties
    let restaurantsData = BehaviorRelay<[Restaurant]>(value: [])
    // - Private Properties
    private let mocked: MockedItem = .init()
    private let disposeBag = DisposeBag()
    
    init() {
        self.restaurantsData.accept(self.mocked.restaurants)
    }
}

// MARK: - RestaurantsMapInteractorImpl: RestaurantsMapInteractor
extension RestaurantsMapInteractorImpl: RestaurantsMapInteractor {
    
}
