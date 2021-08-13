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
    private let recipes = BehaviorRelay<[Recipe]>(value: [])
    
    // - Base
    init(router: HomeNavigationProtocol, interactor: HomeInteractor) {
        self.router = router
        self.interactor = interactor
        self.binding()
    }
    
    func selectCategoryCell(model: HomeViewContent.CategoryCellItem) {
        self.router.showCategoryDetails(details: model)
    }
    
    func selectRecipeCell(model: HomeViewContent.RecipeCellItem) {
        
        guard let value = self.recipes.value.first(where: {$0.id == model.id}) else { return }
        self.router.showRecipeDetails(details: value)
    }
}

// MARK: - Private logic
private extension HomePresenter {
    
    private func binding() {
        self.interactor.chefCraftRecipes
            .map { [weak self] recipes in
                self?.mapToViewData(recipes)
            }
            .ignoreNil()
            .bind(to: viewDataPublisher)
            .disposed(by: disposeBag)
        
        self.interactor.chefCraftRecipes
            .asObservable()
            .map({ $0?.recipes})
            .ignoreNil()
            .bind(to: self.recipes)
            .disposed(by: self.disposeBag)
            
    }
    
    private func mapToViewData(_ recipes: UserRecipes?) -> HomeViewContent? {
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
