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
        
        let data = self.mapToViewData(session: ChefCraftAllRecipes(id: "1", collectionsRecipes: [
            ChefCraftCollectionRecipes(id: "1", name: "First Recipes"),
            ChefCraftCollectionRecipes(id: "2", name: "Second Recipes"),
            ChefCraftCollectionRecipes(id: "3", name: "3 Recipes"),
            ChefCraftCollectionRecipes(id: "4", name: "4 Recipes"),
            ChefCraftCollectionRecipes(id: "5", name: "5 Recipes"),
            ChefCraftCollectionRecipes(id: "6", name: "6 Recipes"),
            ChefCraftCollectionRecipes(id: "7", name: "7 Recipes"),
            ChefCraftCollectionRecipes(id: "8", name: "8 Recipes"),
            ChefCraftCollectionRecipes(id: "9", name: "9 Recipes"),
            ChefCraftCollectionRecipes(id: "10", name: "10 Recipes")
        ], recipes: [
            ChefCraftRecipe(id: "1", name: "First RECIPE", description: "First RECIPE - description"),
            ChefCraftRecipe(id: "2", name: "Second RECIPE", description: "Second RECIPE - description")
        ]))
        
        self.viewDataPublisher.accept(data)
    }
    
    func mapToViewData(session: ChefCraftAllRecipes) -> ChefCraftOverviewViewData {
        let collectionsRecipesHeader = ChefCraftOverviewViewData.CollectionsRecipesHeader(
            collectionsRecipes:
                session.collectionsRecipes
                .map {
                    ChefCraftOverviewViewData.CollectionRecipes(
                        id: $0.id,
                        title: $0.name
                    )
                })
        
        let recipesHeader = ChefCraftOverviewViewData.RecipesHeader(recipesHeader: session.recipes.map {
            ChefCraftOverviewViewData.Recipes(id: $0.id,
                                              title: $0.name,
                                              description: $0.description
            )
        })
        
        let sectionItems: [ChefCraftOverviewContentBox] = [
            .collectionsRecipesHeader(item: collectionsRecipesHeader),
            .recipesHeader(item: recipesHeader)
        ]
        
        return ChefCraftOverviewViewData(
            id: session.id,
            previewId: "1",
            sectionModel: AnimatableSection<ChefCraftOverviewContentBox>(items: sectionItems)
        )
    }
}
