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
    private let homeMessageDatabaseProvider: DatabaseUserRecipesProviderProtocol
    private let disposeBag = DisposeBag()

    init(homeMessageDatabaseProvider: DatabaseUserRecipesProviderProtocol) {
        self.homeMessageDatabaseProvider = homeMessageDatabaseProvider
        self.binding()
    }
}

// MARK: - Private logic
private extension HomeInteractorImpl {
    
    private func binding() {
        
        let recipes = ChefCraftAllRecipes(id: "1", collectionsRecipes: [
            ChefCraftCollectionRecipes(id: "1", name: "First Recipes", image: "soup", recipes: [
                ChefCraftRecipe(id: "1", name: "First RECIPE", image: "bitmap", description: "These days it may seem odd to speak of grandma's cookie receipt, but at one time the only meaning of receipt was recipe. The first recorded use of receipt is a reference to a medicinal preparation in Chaucer's Canterbury Tales (c. 1386).", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ]),
                ChefCraftRecipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
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
                ]),
                ChefCraftRecipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
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
                ]),
                ChefCraftRecipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
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
                ]),
                ChefCraftRecipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
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
                ]),
                ChefCraftRecipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
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
                ]),
                ChefCraftRecipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
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
                ]),
                ChefCraftRecipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
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
                ]),
                ChefCraftRecipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
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
            ]),
            ChefCraftRecipe(id: "3", name: "RECIPE #3", image: "bitmap", description: "#3 RECIPE - description",  owner: "Sarah", isLike: false, stars: 3, about: "Second RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 200),
                RecipeComposition(type: .ingredients, value: 7),
                RecipeComposition(type: .totalTime, value: 40)
            ])
        ])
        
        self.homeMessageDatabaseProvider.saveChefCraftAllRecipe(with: recipes)
            .subscribe()
            .disposed(by: self.disposeBag)
        
        self.homeMessageDatabaseProvider.subscribeOnChefCraftAllRecipe()
            .subscribe(onNext: {[weak self] allRecipes in
                self?.chefCraftRecipes.accept(recipes)
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - HomeInteractorImpl: HomeInteractor
extension HomeInteractorImpl : HomeInteractor {
 
}
