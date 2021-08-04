//
//  CategoryRecipesPresenter.swift
//  shell
//
//  Created by Work on 04.08.2021.
//  Copyright © 2021 CoreTeka. All rights reserved.
//

import RxSwift
import RxCocoa

class CategoryRecipesPresenter {

    // - Private Properties
    private let disposeBag = DisposeBag()
    
    private let router: CategoryRecipesNavigation
    private let interactor: CategoryRecipesInteractor

    // - Base
    init(router: CategoryRecipesNavigation, interactor: CategoryRecipesInteractor) {
        self.router = router
        self.interactor = interactor
        self.binding()
    }
    
    // - Private functions
    private func binding() {
        
    }

}
