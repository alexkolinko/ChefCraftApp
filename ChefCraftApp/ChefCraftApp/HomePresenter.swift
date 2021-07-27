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
    let viewDataPublisher = BehaviorRelay<ChefCraftOverviewViewData?>(value: nil)
    
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
    
   private func mapToViewData(_ recipes: ChefCraftAllRecipes?) -> ChefCraftOverviewViewData? {
        guard let recipes = recipes else { return nil }
        let collectionsRecipesHeader = ChefCraftOverviewViewData.RecipesCategoriesSection(
            collectionsRecipes:
                recipes.collectionsRecipes
                .map {
                    CollectionRecipes(
                        id: $0.id,
                        title: $0.name
                    )
                })
        
        let recipesHeader = ChefCraftOverviewViewData.MainRecipesSection(recipesHeader: recipes.recipes.map {
            Recipes(id: $0.id,
                                              title: $0.name,
                                              description: $0.description
            )
        })
        
        let sectionItems: [ChefCraftOverviewContentBox] = [
            .collectionsRecipesHeader(item: collectionsRecipesHeader),
            .recipesHeader(item: recipesHeader)
        ]
        
        return ChefCraftOverviewViewData(
            id: recipes.id,
            previewId: "1",
            sectionModel: AnimatableSection<ChefCraftOverviewContentBox>(items: sectionItems)
        )
    }
}
