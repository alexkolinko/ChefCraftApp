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
    var cookedRecipesPerDay: BehaviorRelay<Int> { get }
    var cookedRecipesPerWeek: BehaviorRelay<Int> { get }
    var missedRecipes: BehaviorRelay<Int> { get }
    var needToBeCook: BehaviorRelay<Int> { get }
}

// MARK: - ProfileInteractorImpl
/// Implementation class for ProfileInteractor
final class ProfileInteractorImpl: ProfileInteractor {
    
    // - Internal Properties
    let cookedRecipesPerDay = BehaviorRelay<Int>.init(value: 0)
    let cookedRecipesPerWeek = BehaviorRelay<Int>.init(value: 0)
    let missedRecipes = BehaviorRelay<Int>.init(value: 0)
    let needToBeCook = BehaviorRelay<Int>.init(value: 0)
    
    // - Private Properties
    private let userProgressService: UserProgressServiceProtocol
    private let databaseProvider: DatabaseRecipeProviderProtocol
    private let disposeBag = DisposeBag()
    
    private let mockedRecipes: MockedItem = .init()
    private let recipes = BehaviorRelay<[Recipe]>.init(value: [])
    
    init(userProgressService: UserProgressServiceProtocol,databaseProvider: DatabaseRecipeProviderProtocol) {
        self.userProgressService = userProgressService
        self.databaseProvider = databaseProvider
        
        self.binding()
    }
}

// MARK: - ProfileInteractorImpl + Private
private extension ProfileInteractorImpl {
    func binding() {
        
        self.databaseProvider.getRecipes()
            .subscribe(onSuccess: { [weak self] recipes in
                self?.recipes.accept(recipes)
            })
            .disposed(by: self.disposeBag)
        
        self.databaseProvider.subscribeOnRecipes()
            .subscribe(onNext: { [weak self] recipes in
                self?.recipes.accept(recipes)
            })
            .disposed(by: self.disposeBag)
        
        self.recipes
            .subscribe(onNext: { [weak self] recipes in
                let mockedItems = self?.mockedRecipes.userRecipes.recipes ?? []
                self?.userProgressService.input.recipes.onNext(recipes)
                self?.userProgressService.input.mockedRecipes.onNext(mockedItems)
            })
            .disposed(by: self.disposeBag)
        
        self.userProgressService.output.result
            .subscribe(onNext: { [weak self] result in
                self?.cookedRecipesPerDay.accept(result.cookedRecipesPerDay)
                self?.cookedRecipesPerWeek.accept(result.cookedRecipesPerWeek)
                self?.missedRecipes.accept(result.missedRecipes)
                self?.needToBeCook.accept(result.needToBeCook)
            })
            .disposed(by: self.disposeBag)
        
//        self.userProgressService.output.cookedRecipesPerDay
//            .bind(to: self.cookedRecipesPerDay)
//            .disposed(by: self.disposeBag)
//
//        self.userProgressService.output.cookedRecipesPerWeek
//            .bind(to: self.cookedRecipesPerWeek)
//            .disposed(by: self.disposeBag)
//
//        self.userProgressService.output.missedRecipes
//            .bind(to: self.missedRecipes)
//            .disposed(by: self.disposeBag)
//
//        self.userProgressService.output.needToBeCook
//            .bind(to: self.needToBeCook)
//            .disposed(by: self.disposeBag)
    }
}
