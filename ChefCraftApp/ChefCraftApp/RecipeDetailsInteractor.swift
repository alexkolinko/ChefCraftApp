//
//  RecipeDetailsInteractor.swift
//  ChefCraftApp
//
//  Created by Work on 29.07.2021.
//

import RxCocoa
import RxSwift

// MARK: - RecipeDetailsInteractor
/// Abstract logic layer for RecipeDetailsInteractorImpl
protocol RecipeDetailsInteractor {
    
    var recipeData: BehaviorRelay<Recipe?> { get }
    var recipeRating: BehaviorRelay<Int> { get }
    var recipeFavorite: BehaviorRelay<Bool> { get }
    
    func updateRating(_ rating: Int)
    func updateLike(_ isLike: Bool)
    
}

// MARK: - RecipeDetailsInteractorImpl
/// Implementation class for RecipeDetailsInteractor
class RecipeDetailsInteractorImpl {
    
    // - Internal Properties
    var recipeData = BehaviorRelay<Recipe?>(value: nil)
    var recipeRating = BehaviorRelay<Int>(value: 0)
    var recipeFavorite = BehaviorRelay<Bool>(value: false)
    
    // - Private Properties
    private let details: Recipe
    private let databaseProvider: DatabaseRecipeProviderProtocol
    private let favoritesDatabaseProvider: DatabaseFavoritesProvider
    private let disposeBag = DisposeBag()
    
    init(databaseProvider: DatabaseRecipeProviderProtocol, favoritesDatabaseProvider: DatabaseFavoritesProvider, details: Recipe) {
        self.databaseProvider = databaseProvider
        self.favoritesDatabaseProvider = favoritesDatabaseProvider
        self.details = details
        self.binding()
    }
}

// MARK: - Private logic
private extension RecipeDetailsInteractorImpl {
    func binding() {
        
        self.recipeData.accept(self.details)
        
        self.databaseProvider.getRecipe(id: details.id)
            .subscribe(onSuccess: { [weak self] recipe in
                self?.recipeRating.accept(recipe.stars)
                self?.recipeFavorite.accept(recipe.isLike)
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - RecipeDetailsInteractorImpl: RecipeDetailsInteractor
extension RecipeDetailsInteractorImpl: RecipeDetailsInteractor {
    func updateLike(_ isLike: Bool) {
        guard let recipe = self.recipeData.value else { return }
        let newModel = Recipe(id: recipe.id, name: recipe.name, image: recipe.image, description: recipe.description, owner: recipe.owner, isLike: isLike, stars: recipe.stars, about: recipe.about, compositions: recipe.compositions)
        self.databaseProvider.saveRecipe(with: newModel).subscribe().disposed(by: self.disposeBag)
    }
    
    func updateRating(_ rating: Int) {
        guard let recipe = self.recipeData.value else { return }
        let newModel = Recipe(id: recipe.id, name: recipe.name, image: recipe.image, description: recipe.description, owner: recipe.owner, isLike: recipe.isLike, stars: rating, about: recipe.about, compositions: recipe.compositions)
        self.databaseProvider.saveRecipe(with: newModel).subscribe().disposed(by: self.disposeBag)
    }
}
