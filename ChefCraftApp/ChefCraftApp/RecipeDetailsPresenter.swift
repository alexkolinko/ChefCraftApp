//
//  RecipeDetailsPresenter.swift
//  ChefCraftApp
//
//  Created by Work on 29.07.2021.
//

import RxSwift
import RxCocoa

class RecipeDetailsPresenter {
    
    // - Internal Properties
    let viewDataPublisher = BehaviorRelay<RecipeOwerViewData?>(value: nil)
    let imageHeader = BehaviorRelay<String?>(value: nil)
    
    let details: Recipe
    
    // - Private Properties
    private let disposeBag = DisposeBag()
    
    private let router: RecipeDetailsNavigation
    private let interactor: RecipeDetailsInteractor
    
    // - Base
    init(router: RecipeDetailsNavigation, interactor: RecipeDetailsInteractor, details: Recipe) {
        self.router = router
        self.interactor = interactor
        self.details = details
        self.binding()
    }
    
    // - Private functions
    private func binding() {
        let data = self.mapToViewData(self.details)
        self.imageHeader.accept(self.details.image)
        self.viewDataPublisher.accept(data)
    }
    
    func popView() {
        self.router.popView()
    }
    
    private func mapToViewData(_ recipe: Recipe) -> RecipeOwerViewData? {
        
        let recipeHeader = RecipeOwerViewData.RecipeHeaderSection(model: RecipeHeaderSectionModel(
            id: "1",
            title: recipe.title,
            owner: recipe.owner,
            stars: recipe.stars
        ))
        let recipeCompositionsHeader = RecipeOwerViewData.RecipeCompositionsSection(compositions: recipe.compositions.map {
            RecipeCompositionCellModel(
                id: "1",
                type: $0.type,
                value: $0.value
            )
        })
        let recipeAboutHeader = RecipeOwerViewData.RecipeAboutSection(about: recipe.about)
        let sectionItems: [RecipeOverviewContentBox] = [
            .recipeHeader(item: recipeHeader),
            .recipeCompositionsHeader(item: recipeCompositionsHeader),
            .recipeAboutHeader(item: recipeAboutHeader)
        ]
        
        return RecipeOwerViewData(id: recipe.id, sectionModel: AnimatableSection<RecipeOverviewContentBox>(items: sectionItems))
    }
}
