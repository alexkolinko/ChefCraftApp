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
    let viewDataPublisher = BehaviorRelay<Output?>(value: nil)
    
    // - Private Properties
    private let disposeBag = DisposeBag()
    private let details: HomeViewContent.RecipeCellItem
    private let router: RecipeDetailsNavigation
    private let interactor: RecipeDetailsInteractor
    
    // - Base
    init(router: RecipeDetailsNavigation, interactor: RecipeDetailsInteractor, details: HomeViewContent.RecipeCellItem) {
        self.router = router
        self.interactor = interactor
        self.details = details
        self.binding()
    }
    
    // - Private functions
    private func binding() {
        let data = self.mapToViewData(self.details)
        self.viewDataPublisher.accept(Output(content: data, imageHeader: self.details.image))
    }
    
    func popView() {
        self.router.popView()
    }
    
    func selectRating(_ rating: Int) {
       print("RATING ---- \(rating)")
    }
    
    private func mapToViewData(_ recipe: HomeViewContent.RecipeCellItem) -> RecipeDetailsViewContent {
        
        let recipeHeader = RecipeDetailsViewContent.HeaderSection(
            id: "1",
            title: recipe.title,
            owner: recipe.owner,
            stars: recipe.stars
        )
        let recipeCompositionsHeader = RecipeDetailsViewContent.CompositionsSection(compositions: recipe.compositions.map {
            RecipeDetailsViewContent.CompositionCellItem(
                id: "1",
                type: $0.type,
                value: $0.value
            )
        })
        let recipeAboutHeader = RecipeDetailsViewContent.AboutSection(about: recipe.about)
        let sectionItems: [RecipeDetailsOverviewContentBox] = [
            .header(item: recipeHeader),
            .compositions(item: recipeCompositionsHeader),
            .about(item: recipeAboutHeader)
        ]
        
        return RecipeDetailsViewContent(id: recipe.id, sectionModel: AnimatableSection<RecipeDetailsOverviewContentBox>(items: sectionItems))
    }
}

extension RecipeDetailsPresenter {
    
    struct Output {
    let content: RecipeDetailsViewContent
    let imageHeader: String
    }
    
}
