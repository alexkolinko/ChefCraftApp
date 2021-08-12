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
    
    // - Private functions
    private func binding() {
        self.interactor.favoritesData
            .subscribe(onNext: { [weak self] recipes in
                let favoriteRecipes = recipes.compactMap { model -> FavoriteCellModel? in
                    return FavoriteCellModel(model: model)
                }
                let section = FavoritesSectionModel(id: "favorites_recipes_section", items: favoriteRecipes)

                self?.viewData.accept(Output(favoritesRecipesDataSource: [section]))
            })
            .disposed(by: self.disposeBag)
    }

}

// MARK: - Internal Output
extension FavoritesPresenter {
    
    struct Output {
        let favoritesRecipesDataSource: [FavoritesSectionModel]
    }
}
