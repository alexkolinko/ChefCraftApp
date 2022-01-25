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
    var recipeRating: BehaviorRelay<Int?> { get }
    var recipeCoocked: BehaviorRelay<Bool?> { get }
    var recipeFavorite: BehaviorRelay<String?> { get }
    
    func updateRating(_ rating: Int)
    func updateLike(_ isLike: Bool)
    func updateCooked(_ isCooked: Bool)
    
}

// MARK: - RecipeDetailsInteractorImpl
/// Implementation class for RecipeDetailsInteractor
class RecipeDetailsInteractorImpl {
    
    // - Internal Properties
    let recipeData = BehaviorRelay<Recipe?>(value: nil)
    let recipeRating = BehaviorRelay<Int?>(value: nil)
    let recipeCoocked = BehaviorRelay<Bool?>(value: nil)
    let recipeFavorite = BehaviorRelay<String?>(value: nil)
    
    // - Private Properties
    private let details: Recipe
    private let favorites = BehaviorRelay<[String]>(value: [])
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
                self?.recipeCoocked.accept(recipe.cooked)
            })
            .disposed(by: self.disposeBag)
        
        self.favoritesDatabaseProvider.getFavorites()
            .subscribe(onSuccess: { [weak self] favorites in
                self?.favorites.accept(favorites.recipes)
            })
            .disposed(by: self.disposeBag)
        
        self.favorites
            .subscribe(onNext: { [weak self] value in
                guard let favoriteObject = value.first(where: { $0 == self?.details.id }) else { return }
                self?.recipeFavorite.accept(favoriteObject)
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - RecipeDetailsInteractorImpl: RecipeDetailsInteractor
extension RecipeDetailsInteractorImpl: RecipeDetailsInteractor {
    
    func updateLike(_ isLike: Bool) {
        var recipes = self.favorites.value
        isLike ? recipes.append(self.details.id) : recipes.remove(object: self.details.id)
        self.favoritesDatabaseProvider.saveFavorites(with: Favorites(recipes: recipes)).subscribe().disposed(by: self.disposeBag)
    }
    
    func updateCooked(_ isCooked: Bool) {
        guard var recipe = self.recipeData.value else { return }
        let today = Date()
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "dd MMM yyyy, HH:mm"
        let date = formatter3.string(from: today)
        recipe.setCooked(cooked: isCooked, dateOfCooked: isCooked ? date : "")
        self.databaseProvider.saveRecipe(with: recipe).subscribe().disposed(by: self.disposeBag)
    }
    
    func updateRating(_ rating: Int) {
        guard var recipe = self.recipeData.value else { return }
        recipe.setStars(stars: rating)
        self.databaseProvider.saveRecipe(with: recipe).subscribe().disposed(by: self.disposeBag)
    }
}
