//
//  ProfilePresenter.swift
//  ChefCraftApp
//
//  Created by Work on 13.12.2021.
//  
//

import RxSwift
import RxCocoa

// MARK: - ProfileInteractor
/// Abstract logic layer for ProfilePresenterImpl
protocol ProfilePresenter {
    
}

// MARK: - ProfilePresenterImpl
final class ProfilePresenterImpl {

    // - Private Properties
    private let disposeBag = DisposeBag()
    
    private let router: ProfileNavigation
    private let interactor: ProfileInteractor

    // - Base
    init(router: ProfileNavigation, interactor: ProfileInteractor) {
        self.router = router
        self.interactor = interactor
        
        self.binding()
    }

}

// MARK: - ProfilePresenterImpl + private
private extension ProfilePresenterImpl {
    func binding() {
        self.interactor.userRecipesCountPerDay()
            .subscribe(onNext: { count in
                print("RECIPEE COUNT -- \(count)")
            }).disposed(by: self.disposeBag)
    }
}

// MARK: - ProfilePresenterImpl: ProfilePresenter
extension ProfilePresenterImpl : ProfilePresenter {
    
}

