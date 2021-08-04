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
            ChefCraftCollectionRecipes(id: "1", name: "First Recipes", image: "soup", recipes: [
                ChefCraftRecipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            ChefCraftCollectionRecipes(id: "2", name: "Second Recipes", image: "breakfast", recipes: [
                ChefCraftRecipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            ChefCraftCollectionRecipes(id: "3", name: "3 Recipes", image: "soup", recipes: [
                ChefCraftRecipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            ChefCraftCollectionRecipes(id: "4", name: "4 Recipes", image: "breakfast", recipes: [
                ChefCraftRecipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            ChefCraftCollectionRecipes(id: "5", name: "5 Recipes", image: "soup", recipes: [
                ChefCraftRecipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            ChefCraftCollectionRecipes(id: "6", name: "6 Recipes", image: "breakfast", recipes: [
                ChefCraftRecipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            ChefCraftCollectionRecipes(id: "7", name: "7 Recipes", image: "soup", recipes: [
                ChefCraftRecipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            ChefCraftCollectionRecipes(id: "8", name: "8 Recipes", image: "breakfast", recipes: [
                ChefCraftRecipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
        ], recipes: [
            ChefCraftRecipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            ChefCraftRecipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Second RECIPE - description",  owner: "Sarah", isLike: false, stars: 3, about: "Second RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 200),
                RecipeComposition(type: .ingredients, value: 7),
                RecipeComposition(type: .totalTime, value: 40)
            ])
        ])
        
        self.chefCraftRecipes.accept(recipes)
    }
}
