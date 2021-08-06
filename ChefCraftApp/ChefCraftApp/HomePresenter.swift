//
//  HomePresenter.swift
//  ChefCraftApp
//
//  Created by Work on 23.07.2021.
//

import RxSwift
import RxCocoa

class HomePresenter {
    
    // - Internal properties
    let viewDataPublisher = BehaviorRelay<HomeViewContent?>(value: nil)
    
    // - Private Properties
    private let disposeBag = DisposeBag()
    private let router: HomeNavigationProtocol
    private let interactor: HomeInteractor
    
    // - Base
    init(router: HomeNavigationProtocol, interactor: HomeInteractor) {
        self.router = router
        self.interactor = interactor
        self.binding()
    }
    
    func selectCell(model: HomeViewContent.RecipeCellItem) {
        self.router.showRecipeDetails(details: model)
    }
    
    // - Private functions
    private func binding() {
        
        self.interactor.chefCraftRecipes
            .map { [weak self] recipes in
                self?.mapToViewData(recipes)
            }
            .ignoreNil()
            .bind(to: viewDataPublisher)
            .disposed(by: disposeBag)
    }
    
    private func mapToViewData(_ recipes: ChefCraftAllRecipes?) -> HomeViewContent? {
        guard let recipes = recipes else { return nil }
        let collectionsRecipesHeader = HomeViewContent.CategoriesSection(categories: recipes.collectionsRecipes.map {
            HomeViewContent.CategoryCellItem(
                id: $0.id,
                title: $0.name,
                image: $0.image,
                recipes: $0.recipes
            )
        })
        
        let recipesHeader = HomeViewContent.RecipesSection(recipes: recipes.recipes.map {
            HomeViewContent.RecipeCellItem(
                id: $0.id,
                title: $0.name,
                image: $0.image,
                description: $0.description,
                owner: $0.owner,
                isLike: $0.isLike,
                stars: $0.stars,
                about: $0.about,
                compositions: $0.compositions
            )
        })
        
        let sectionItems: [HomeOverviewContentBox] = [
            .categories(item: collectionsRecipesHeader),
            .recipes(item: recipesHeader)
        ]
        
        return HomeViewContent(
            id: recipes.id,
            previewId: "1",
            sectionModel: AnimatableSection<HomeOverviewContentBox>(items: sectionItems)
        )
    }
}
