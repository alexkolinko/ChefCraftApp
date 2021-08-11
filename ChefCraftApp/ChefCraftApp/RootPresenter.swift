//
//  RootPresenter.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import RxSwift
import RxCocoa

final class RootPresenter {
    
    // - Private Properties
    private let disposeBag = DisposeBag()
    private let router: RootNavigationProtocol
    private let interactor: RootInteractorProtocol
    
    init(router: RootNavigationProtocol, interactor: RootInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        self.binding()
    }
    
    // - Private BL
    private func binding() {
        
    }
}
