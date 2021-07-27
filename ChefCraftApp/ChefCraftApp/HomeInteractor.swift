//
//  HomeInteractor.swift
//  ChefCraftApp
//
//  Created by Work on 23.07.2021.
//

import RxCocoa
import RxSwift

// MARK: - HomeInteractor
/// Abstract logic layer for HomeInteractorImpl
protocol HomeInteractor {
    var chefCraftRecipes: BehaviorRelay<ChefCraftAllRecipes?> { get }
}

// MARK: - HomeInteractorImpl
/// Implementation class for HomeInteractor
class HomeInteractorImpl {
    
    // - Internal Properties
    var chefCraftRecipes = BehaviorRelay<ChefCraftAllRecipes?>(value: nil)
    // - Private Properties
    private let disposeBag = DisposeBag()

    init() {
        self.binding()
    }
}

// MARK: - HomeInteractorImpl: HomeInteractor
extension HomeInteractorImpl : HomeInteractor {
    
    
    // - Private BL
    private func binding() {
        
        let recipes = ChefCraftAllRecipes(id: "1", collectionsRecipes: [
            ChefCraftCollectionRecipes(id: "1", name: "First Recipes"),
            ChefCraftCollectionRecipes(id: "2", name: "Second Recipes"),
            ChefCraftCollectionRecipes(id: "3", name: "3 Recipes"),
            ChefCraftCollectionRecipes(id: "4", name: "4 Recipes"),
            ChefCraftCollectionRecipes(id: "5", name: "5 Recipes"),
            ChefCraftCollectionRecipes(id: "6", name: "6 Recipes"),
            ChefCraftCollectionRecipes(id: "7", name: "7 Recipes"),
            ChefCraftCollectionRecipes(id: "8", name: "8 Recipes"),
            ChefCraftCollectionRecipes(id: "9", name: "9 Recipes"),
            ChefCraftCollectionRecipes(id: "10", name: "10 Recipes")
        ], recipes: [
            ChefCraftRecipe(id: "1", name: "First RECIPE", description: "First RECIPE - description"),
            ChefCraftRecipe(id: "2", name: "Second RECIPE", description: "Second RECIPE - description")
        ])
        
        self.chefCraftRecipes.accept(recipes)
    }
}
