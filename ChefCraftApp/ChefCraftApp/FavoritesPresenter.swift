//
//  FavoritesPresenter.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import RxSwift
import RxCocoa

class FavoritesPresenter {

    // - Private Properties
    private let disposeBag = DisposeBag()
    
    private let router: FavoritesNavigation
    private let interactor: FavoritesInteractor

    // - Base
    init(router: FavoritesNavigation, interactor: FavoritesInteractor) {
        self.router = router
        self.interactor = interactor
        self.binding()
    }
    
    // - Private functions
    private func binding() {
        
    }

}
