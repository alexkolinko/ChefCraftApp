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
    /// Selected restaurant model from user interaction with mapkit view on view controller
    var selectedRestaurant = BehaviorRelay<Restaurant?>(value: nil)
    /// All available recipes
    var restaurants = BehaviorRelay<[Restaurant]>(value: [])

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
        if let selected = self.selectedRestaurant.value?.id, let cuurentSelected = Int(selected) {
            if cuurentSelected != id {
                self.selectedRestaurant.accept(self.restaurants.value.first(where: { item in
                    guard let recipeId = Int(item.id) else { return false}
                    return recipeId == id
                }) )
            } else {
                self.selectedRestaurant.accept(nil)
            }
        } else {
            self.selectedRestaurant.accept(self.restaurants.value.first(where: { item in
                guard let recipeId = Int(item.id) else { return false}
                return recipeId == id
            }))
        }
        
    }
    
    // - Private BL
    private func binding() {
        self.interactor.restaurantsData
            .bind(to: self.restaurants)
            .disposed(by: self.disposeBag)
    }

}
