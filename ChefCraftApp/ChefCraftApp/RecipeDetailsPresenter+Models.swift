//
//  RecipeDetailsPresenter+Models.swift
//  ChefCraftApp
//
//  Created by Work on 09.12.2021.
//

import RxSwift
import RxCocoa

// MARK: - RecipeDetailsPresenter + Output
extension RecipeDetailsPresenter {
    struct Output {
        let content: Observable<RecipeDetailsViewContent>
        let imageHeader: Observable<String>
        let applyLikeAction: Observable<Bool>
        let applyRatingSelected: Observable<Int>
    }
}

// MARK: - RecipeDetailsPresenter + Input
extension RecipeDetailsPresenter {
    struct Input {
        let onAction: AnyObserver<Action>
    }
}

// MARK: - RecipeDetailsPresenter + Action
extension RecipeDetailsPresenter {
    enum Action {
        case popView
        case selectRating(_ rating: Int)
        case selectLike(_ value: Bool)
    }
}
