//
//  HomePresenter.swift
//  ChefCraftApp
//
//  Created by Work on 23.07.2021.
//

import RxSwift
import RxCocoa

class HomePresenter {

    // - Private Properties
    private let disposeBag = DisposeBag()
    
    private let router: HomeNavigationProtocol
    private let interactor: HomeInteractor

    // - Base
    init(router: HomeNavigationProtocol, interactor: HomeInteractor) {
        self.router = router
        self.interactor = interactor
        self.binding()
    }
    
    // - Private functions
    private func binding() {
        
    }

}
