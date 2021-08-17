//
//  FavoritesPresenter.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import RxSwift
import RxCocoa

class FavoritesPresenter {
    
    // - Internal Propreties
    let viewData = BehaviorRelay<Output?>(value: nil)
    
    // - Private Properties
    private let disposeBag = DisposeBag()
    
    private let router: FavoritesNavigation
    private let interactor: FavoritesInteractor
    
    // - Base
    init(router: FavoritesNavigation, interactor: FavoritesInteractor) {
        self.router = router
        self.interactor = interactor
        self.binding()
    }
}

// MARK: - Private logic
private extension FavoritesPresenter {
    
    func binding() {
        Observable.combineLatest(self.interactor.recipesData, self.interactor.favoritesRecipes, self.interactor.ratingRecipes)
            .subscribe(onNext: { [weak self] recipes, favoritesRecipes, ratingRecipes in
                self?.mapToModel(recipes, favoritesRecipes, ratingRecipes)
            })
            .disposed(by: self.disposeBag)
    }
    
    func mapToModel(_ recipes: [Recipe], _ favoritesRecipes: [String], _ ratingRecipes: [Recipe]) {
        let filteredRecipes = recipes
            .filter({ favoritesRecipes.contains($0.id) })
            .map { recipe -> Recipe in
                var updatedRecipe = recipe
                if let stars = ratingRecipes.first(where: { $0.id == updatedRecipe.id })?.stars {
                    updatedRecipe.stars = stars
                }
                return updatedRecipe
            }
        
        let favoriteRecipes = filteredRecipes.compactMap { model -> FavoriteCellModel? in
            return FavoriteCellModel(model: model)
        }
        
        let section = FavoritesSectionModel(id: "favorites_recipes_section", items: favoriteRecipes)
        self.viewData.accept(Output(favoritesRecipesDataSource: [section]))
    }
}

// MARK: - Internal Output
extension FavoritesPresenter {
    
    struct Output {
        let favoritesRecipesDataSource: [FavoritesSectionModel]
    }
}
