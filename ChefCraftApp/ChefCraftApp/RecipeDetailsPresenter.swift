//
//  RecipeDetailsPresenter.swift
//  ChefCraftApp
//
//  Created by Work on 29.07.2021.
//

import RxSwift
import RxCocoa

// MARK: - RecipeDetailsPresenterProtocol
/// Abstract logic layer for RecipeDetailsPresenter
protocol RecipeDetailsPresenterProtocol {
    /// Input channel (for user interactions or view signalers)
    var input: RecipeDetailsPresenter.Input { get }
    /// Output channel (for data binding and commands handle from presenter)
    var output: RecipeDetailsPresenter.Output { get }
    
    func getItem(index: Int) -> RecipeDetailsOverviewContentBox?
}

final class RecipeDetailsPresenter: RecipeDetailsPresenterProtocol {
    
    let output: Output
    let input: Input
    
    // - Private Properties
    private let disposeBag = DisposeBag()
    private let router: RecipeDetailsNavigation
    private let interactor: RecipeDetailsInteractor
    private let actionSubject = PublishSubject<Action>()
    private let recipeDatails = BehaviorRelay<RecipeDetailsViewContent?>(value: nil)
    private let imageHeader = BehaviorRelay<String?>(value: nil)
    private let applyLikeAction = BehaviorRelay<Bool?>(value: nil)
    private let applyCookedAction = BehaviorRelay<Bool?>(value: nil)
    private let applyRatingSelected = BehaviorRelay<Int?>(value: nil)
    
    // - Base
    init(router: RecipeDetailsNavigation, interactor: RecipeDetailsInteractor) {
        self.router = router
        self.interactor = interactor
        
        self.output = .init(
            content: self.recipeDatails.asObservable().ignoreNil(),
            imageHeader: self.imageHeader.asObservable().ignoreNil(),
            applyLikeAction: self.applyLikeAction.asObservable().ignoreNil(),
            applyCookedAction: self.applyCookedAction.asObservable().ignoreNil(),
            applyRatingSelected: self.applyRatingSelected.asObservable().ignoreNil()
        )
        self.input = .init(onAction: self.actionSubject.asObserver())
        
        self.binding()
    }
    
    func getItem(index: Int) -> RecipeDetailsOverviewContentBox? {
        return self.recipeDatails.value?.sectionModel.items[index]
    }
}

// MARK: - Private logic
private extension RecipeDetailsPresenter {
    
    func binding() {
        
        Observable.combineLatest(self.interactor.recipeData, self.interactor.recipeRating, self.interactor.recipeFavorite, self.interactor.recipeCoocked)
            .subscribe(onNext: { [weak self] recipe, rating, favorite, cooked in
                self?.mapData(recipe, rating, favorite, cooked)
            })
            .disposed(by: self.disposeBag)
        
        self.actionSubject
            .subscribe(onNext: { [weak self] action in
                switch action {
                case .popView:
                    self?.popView()
                case let .selectRating(value):
                    self?.selectRating(value)
                case let .selectLike(value):
                    self?.selectLike(value)
                case let .selectCooked(value):
                    self?.selectCooked(value)
                }
            }).disposed(by: self.disposeBag)
    }
    
    func mapData(_ recipe: Recipe?, _ rating: Int?, _ favorite: String?, _ cooked: Bool?) {
        let isFavorite = favorite != nil ? true : false
        let data = self.mapToViewData(recipe, rating, isFavorite, cooked)
        self.recipeDatails.accept(data)
        self.imageHeader.accept(recipe?.image)
        
    }
    
    func mapToViewData(_ recipe: Recipe?, _ rating: Int?, _ favorite: Bool, _ cooked: Bool?) -> RecipeDetailsViewContent? {
        guard let recipe = recipe else { return nil }
        let recipeHeader = RecipeDetailsViewContent.HeaderSection(
            id: "1",
            title: recipe.name,
            owner: recipe.owner,
            stars: rating ?? 0,
            isLike: favorite,
            cooked: cooked ?? false
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
    
    func selectCooked(_ value: Bool) {
        self.applyCookedAction.accept(value)
        self.interactor.updateCooked(value)
    }
}
