//
//  RecipesMapPresenter.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//  
//

import RxSwift
import RxCocoa

// MARK: - RecipesMapInteractor
/// Abstract logic layer for RecipesMapPresenterImpl
//protocol RecipesMapPresenter {
//
//}

// MARK: - RecipesMapPresenterImpl
class RecipesMapPresenterImpl {
    
    // - Internla Propreties
    /// Observable for location service enable status
    var isLocationServicesEnabled = BehaviorRelay<Bool>(value: false)
    /// Observalbe for loading status of recipe's requests
    var isLoadingTerminals = BehaviorRelay<Bool>(value: false)
    /// Selected recipe model from user interaction with mapkit view on view controller
    var selectedTerminal = BehaviorRelay<Recipe?>(value: nil)
    /// All available recipes
    var recipes = BehaviorRelay<[Recipe]>(value: [])
    /// Selected Filters
    var selectedFilters = BehaviorRelay<[Recipe]>(value: [])

    // - Private Properties
    private var disposeBag = DisposeBag()
    private var router: RecipesMapNavigation
    private var interactor: RecipesMapInteractor

    init(router: RecipesMapNavigation, interactor: RecipesMapInteractor) {
        self.router = router
        self.interactor = interactor
        self.binding()
    }
    
    deinit {
        print("Deinit --> \(self)")
    }
    
    // - Internal Logic
    func selectTerminal(with id: Int) {
        if let selected = self.selectedTerminal.value?.id, let cuurentSelected = Int(selected) {
            if cuurentSelected != id {
                self.selectedTerminal.accept(self.recipes.value.first(where: { item in
                    guard let recipeId = Int(item.id) else { return false}
                    return recipeId == id
                }) )
            } else {
                self.selectedTerminal.accept(nil)
            }
        } else {
            self.selectedTerminal.accept(self.recipes.value.first(where: { item in
                guard let recipeId = Int(item.id) else { return false}
                return recipeId == id
            }))
        }
        
    }
    
    // - Private BL
    private func binding() {
        self.interactor.recipesData
            .bind(to: self.recipes)
            .disposed(by: self.disposeBag)
    }

}
