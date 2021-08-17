//
//  RootInteractor.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import RxCocoa
import RxSwift

// MARK: - RootInteractorProtocol
protocol RootInteractorProtocol {
    
}

// MARK: - RootInteractor
class RootInteractor {
    
    
    // - Private Properties
    private let disposeBag = DisposeBag()

    init() {
        self.binding()
    }
    
    private func binding() {
        
    }
}

// MARK: - RootInteractor: RootInteractorProtocol
extension RootInteractor: RootInteractorProtocol {
    
}
