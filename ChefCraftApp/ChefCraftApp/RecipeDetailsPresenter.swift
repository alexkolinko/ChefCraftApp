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
    private let router: RecipeDetailsNavigation
    private let interactor: RecipeDetailsInteractor
    private let applyLikeAction = BehaviorRelay<Bool?>(value: nil)
    private let applyRatingSelected = BehaviorRelay<Int?>(value: nil)
    
    // - Base
    init(router: RecipeDetailsNavigation, interactor: RecipeDetailsInteractor) {
        self.router = router
        self.interactor = interactor
        self.binding()
    }
    
    func popView() {
        self.router.popView()
    }
    
    func selectRating(_ rating: Int) {
        self.applyRatingSelected.accept(rating)
        self.interactor.updateRating(rating)
    }
    
    func selectLike(_ value: Bool) {
        self.applyLikeAction.accept(value)
        self.interactor.updateLike(value)
    }
}

// MARK: - Private logic
extension RecipeDetailsPresenter {
    
    func binding() {
        Observable.combineLatest(self.interactor.recipeData, self.applyLikeAction, self.applyRatingSelected)
            .subscribe(onNext: { [weak self] recipe, applyLikeAction, applyRatingSelected in
                self?.mapToOutput(recipe, applyLikeAction, applyRatingSelected)
            })
            .disposed(by: self.disposeBag)
    }
    
    func mapToOutput(_ recipe: HomeViewContent.RecipeCellItem?, _ applyLikeAction: Bool?, _ applyRatingSelected: Int?) {
        let data = self.mapToViewData(recipe)
        self.viewDataPublisher.accept(Output(content: data, imageHeader: recipe?.image, applyLikeAction: applyLikeAction, applyRatingSelected: applyRatingSelected))
    }
    
    func mapToViewData(_ recipe: HomeViewContent.RecipeCellItem?) -> RecipeDetailsViewContent? {
        guard let recipe = recipe else { return nil }
        let recipeHeader = RecipeDetailsViewContent.HeaderSection(
            id: "1",
            title: recipe.title,
            owner: recipe.owner,
            stars: recipe.stars,
            isLike: recipe.isLike
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

// MARK: - RecipeDetailsPresenter Output
extension RecipeDetailsPresenter {
    
    struct Output {
        let content: RecipeDetailsViewContent?
        let imageHeader: String?
        let applyLikeAction: Bool?
        let applyRatingSelected: Int?
    }
}
