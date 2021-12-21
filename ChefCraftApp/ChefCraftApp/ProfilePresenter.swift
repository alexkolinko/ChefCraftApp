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
    var output: ProfilePresenterImpl.Output { get }
}

// MARK: - ProfilePresenterImpl
final class ProfilePresenterImpl: ProfilePresenter {
    
    let output: Output

    // - Private Properties
    private let disposeBag = DisposeBag()
    private let progressData = BehaviorRelay<ProgressUserModel?>.init(value: nil)
    private let router: ProfileNavigation
    private let interactor: ProfileInteractor

    // - Base
    init(router: ProfileNavigation, interactor: ProfileInteractor) {
        self.router = router
        self.interactor = interactor
        
        self.output = .init(progressData: self.progressData.asObservable().ignoreNil())
        
        self.binding()
    }

}

// MARK: - ProfilePresenterImpl + private
private extension ProfilePresenterImpl {
    func binding() {
        
        Observable.combineLatest(self.interactor.cookedRecipesPerDay, self.interactor.cookedRecipesPerWeek, self.interactor.missedRecipes,  self.interactor.needToBeCook)
            .subscribe(onNext: { [weak self] perDay, perWeek, missed, needed in
                let progressModel = ProgressUserModel(
                    cookedRecipesPerDay: perDay,
                    cookedRecipesPerWeek: perWeek,
                    missedRecipes: missed,
                    needToBeCook: needed
                )
                self?.progressData.accept(progressModel)
            }).disposed(by: self.disposeBag)
    }
}
