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
    private let mocked: MockedItem = .init()
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
        
        self.recipesData.accept(self.mocked.userRecipes.recipes)
    }
}

// MARK: - FavoritesInteractorImpl: FavoritesInteractor
extension FavoritesInteractorImpl : FavoritesInteractor {
    
}
