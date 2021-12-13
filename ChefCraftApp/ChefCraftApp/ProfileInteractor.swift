//
//  ProfileInteractor.swift
//  ChefCraftApp
//
//  Created by Work on 13.12.2021.
//  
//

import RxCocoa
import RxSwift

// MARK: - ProfileInteractor
/// Abstract logic layer for ProfileInteractorImpl
protocol ProfileInteractor {
    func userRecipesCountPerDay() -> Observable<Int>
}

// MARK: - ProfileInteractorImpl
/// Implementation class for ProfileInteractor
final class ProfileInteractorImpl {
    
    // - Internal Properties

    // - Private Properties
    private let userProgressService: UserProgressServiceProtocol
    private let databaseProvider: DatabaseRecipeProviderProtocol
    private let disposeBag = DisposeBag()
    
    private let recipes = BehaviorRelay<[Recipe]>(value: [])
    
    

//    private let databaseProvider:
//    private let networkProvider:
//
    init(userProgressService: UserProgressServiceProtocol,databaseProvider: DatabaseRecipeProviderProtocol) {
        self.userProgressService = userProgressService
        self.databaseProvider = databaseProvider
    
        self.binding()
    }
}

// MARK: - ProfileInteractorImpl + Private
private extension ProfileInteractorImpl {
    func binding() {
        self.databaseProvider.subscribeOnRecipes()
            .subscribe(onNext: { [weak self] recipes in
                self?.recipes.accept(recipes)
            })
            .disposed(by: self.disposeBag)
        
        self.recipes
            .subscribe(onNext: { [weak self] value in
                self?.userProgressService.input.recipes.onNext(value)
            }).disposed(by: self.disposeBag)
    }
}

// MARK: - ProfileInteractorImpl: ProfileInteractor
extension ProfileInteractorImpl: ProfileInteractor {
    func userRecipesCountPerDay() -> Observable<Int> {
       return self.userProgressService.output.cookedRecipes
    }
    
    
}
