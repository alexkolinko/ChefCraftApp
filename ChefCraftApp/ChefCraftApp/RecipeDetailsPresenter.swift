//
//  RecipeDetailsPresenter.swift
//  ChefCraftApp
//
//  Created by Work on 29.07.2021.
//

import RxSwift
import RxCocoa

class RecipeDetailsPresenter {

    // - Internal Properties
    let details: Recipe
    
    // - Private Properties
    private let disposeBag = DisposeBag()
    
    private let router: RecipeDetailsNavigation
    private let interactor: RecipeDetailsInteractor

    // - Base
    init(router: RecipeDetailsNavigation, interactor: RecipeDetailsInteractor, details: Recipe) {
        self.router = router
        self.interactor = interactor
        self.details = details
        self.binding()
    }
    
    // - Private functions
    private func binding() {
        
    }
    
    func popView() {
        self.router.popView()
    }

}
