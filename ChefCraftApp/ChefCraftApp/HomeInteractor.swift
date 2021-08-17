//
//  HomeInteractor.swift
//  ChefCraftApp
//
//  Created by Work on 23.07.2021.
//

import RxCocoa
import RxSwift

// MARK: - HomeInteractor
/// Abstract logic layer for HomeInteractorImpl
protocol HomeInteractor {
    var chefCraftRecipes: BehaviorRelay<UserRecipes?> { get }
}

// MARK: - HomeInteractorImpl
/// Implementation class for HomeInteractor
class HomeInteractorImpl {
    
    // - Internal Properties
    var chefCraftRecipes = BehaviorRelay<UserRecipes?>(value: nil)
    
    // - Private Properties
    private let mocked: MockedItem = .init()
    private let disposeBag = DisposeBag()

    init() {
        self.binding()
    }
}

// MARK: - Private logic
private extension HomeInteractorImpl {
    
    private func binding() {
        
        self.chefCraftRecipes.accept(self.mocked.userRecipes)
    }
}

// MARK: - HomeInteractorImpl: HomeInteractor
extension HomeInteractorImpl : HomeInteractor {
 
}
