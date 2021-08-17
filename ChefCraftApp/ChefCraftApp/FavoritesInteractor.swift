//
//  FavoritesInteractor.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import RxCocoa
import RxSwift

// MARK: - FavoritesInteractor
/// Abstract logic layer for FavoritesInteractorImpl
protocol FavoritesInteractor {
    var recipesData: BehaviorRelay<[Recipe]> { get }
    var favoritesRecipes: BehaviorRelay<[String]> { get }
    var ratingRecipes: BehaviorRelay<[Recipe]> { get }
}

// MARK: - FavoritesInteractorImpl
/// Implementation class for FavoritesInteractor
class FavoritesInteractorImpl {
    
    // - Internal Properties
    let recipesData = BehaviorRelay<[Recipe]>(value: [])
    let favoritesRecipes = BehaviorRelay<[String]>(value: [])
    let ratingRecipes = BehaviorRelay<[Recipe]>(value: [])
    // - Private Properties
    private let databaseProvider: DatabaseRecipeProviderProtocol
    private let favoritesDatabaseProvider: DatabaseFavoritesProvider
    private let disposeBag = DisposeBag()

    init(databaseProvider: DatabaseRecipeProviderProtocol, favoritesDatabaseProvider: DatabaseFavoritesProvider) {
        self.databaseProvider = databaseProvider
        self.favoritesDatabaseProvider = favoritesDatabaseProvider
        self.binding()
    }
}

private extension FavoritesInteractorImpl {
    func binding() {
        
        let recipes = UserRecipes(id: "1", categoriesRecipes: [
            CategoryRecipes(id: "1", name: "First Recipes", image: "soup", recipes: [
                Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "These days it may seem odd to speak of grandma's cookie receipt, but at one time the only meaning of receipt was recipe. The first recorded use of receipt is a reference to a medicinal preparation in Chaucer's Canterbury Tales (c. 1386).", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ]),
                Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            CategoryRecipes(id: "2", name: "Second Recipes", image: "breakfast", recipes: [
                Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ]),
                Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            CategoryRecipes(id: "3", name: "3 Recipes", image: "soup", recipes: [
                Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ]),
                Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            CategoryRecipes(id: "4", name: "4 Recipes", image: "breakfast", recipes: [
                Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ]),
                Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            CategoryRecipes(id: "5", name: "5 Recipes", image: "soup", recipes: [
                Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ]),
                Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            CategoryRecipes(id: "6", name: "6 Recipes", image: "breakfast", recipes: [
                Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ]),
                Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            CategoryRecipes(id: "7", name: "7 Recipes", image: "soup", recipes: [
                Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ]),
                Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
            CategoryRecipes(id: "8", name: "8 Recipes", image: "breakfast", recipes: [
                Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ]),
                Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Bring a pan of lightly salted water to the boil. Cook the green beans for 2 minutes and drain them.", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 150),
                    RecipeComposition(type: .ingredients, value: 5),
                    RecipeComposition(type: .totalTime, value: 30)
                ])
            ]),
        ], recipes: [
            Recipe(id: "1", name: "First RECIPE", image: "bitmap", description: "First RECIPE - description", owner: "Smith", isLike: true, stars: 4, about: "First RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 150),
                RecipeComposition(type: .ingredients, value: 5),
                RecipeComposition(type: .totalTime, value: 30)
            ]),
            Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Second RECIPE - description",  owner: "Sarah", isLike: false, stars: 3, about: "Second RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 200),
                RecipeComposition(type: .ingredients, value: 7),
                RecipeComposition(type: .totalTime, value: 40)
            ]),
            Recipe(id: "3", name: "RECIPE #3", image: "bitmap", description: "#3 RECIPE - description",  owner: "Sarah", isLike: false, stars: 3, about: "Second RECIPE - is best recipe", compositions: [
                RecipeComposition(type: .calories, value: 200),
                RecipeComposition(type: .ingredients, value: 7),
                RecipeComposition(type: .totalTime, value: 40)
            ])
        ])
        
        self.databaseProvider
            .subscribeOnRecipes()
            .subscribe(onNext: { [weak self] recipes in
                self?.ratingRecipes.accept(recipes)
            })
            .disposed(by: self.disposeBag)
        
        self.favoritesDatabaseProvider.subscribeOnFavorites()
            .subscribe(onNext: { [weak self] favorites in
                self?.favoritesRecipes.accept(favorites.recipes)
            })
            .disposed(by: self.disposeBag)
        
        self.recipesData.accept(recipes.recipes)
    }
}

// MARK: - FavoritesInteractorImpl: FavoritesInteractor
extension FavoritesInteractorImpl : FavoritesInteractor {
    
}
