//
//  FavoritesInteractor.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import RxCocoa
import RxSwift

// MARK: - FavoritesInteractor
/// Abstract logic layer for FavoritesInteractorImpl
protocol FavoritesInteractor {
    var favoritesData: BehaviorRelay<[Recipe]> { get set }
}

// MARK: - FavoritesInteractorImpl
/// Implementation class for FavoritesInteractor
class FavoritesInteractorImpl {
    
    // - Internal Properties
    var favoritesData = BehaviorRelay<[Recipe]>(value: [])
    // - Private Properties
    private let disposeBag = DisposeBag()

    init() {
        self.binding()
    }
}

private extension FavoritesInteractorImpl {
    func binding() {
        
        let recipes = [
            Recipe(id: "1", name: "FIRST", image: "soup", description: "FIRST - description description description description", owner: "I'm", isLike: true, stars: 5, about: "about about about about", compositions: [
                    RecipeComposition(type: .calories, value: 200),
                RecipeComposition(type: .ingredients, value: 4),
                RecipeComposition(type: .totalTime, value: 20)
            ]),
            Recipe(id: "2", name: "SECOND", image: "soup", description: "SECOND - description description description description", owner: "I'm", isLike: true, stars: 5, about: "about about about about", compositions: [
                    RecipeComposition(type: .calories, value: 200),
                RecipeComposition(type: .ingredients, value: 4),
                RecipeComposition(type: .totalTime, value: 20)
            ]),
            Recipe(id: "3", name: "3", image: "soup", description: "3 - description description description description", owner: "I'm", isLike: true, stars: 5, about: "about about about about", compositions: [
                    RecipeComposition(type: .calories, value: 200),
                RecipeComposition(type: .ingredients, value: 4),
                RecipeComposition(type: .totalTime, value: 20)
            ])
        ]
        self.favoritesData.accept(recipes)
    }
}

// MARK: - FavoritesInteractorImpl: FavoritesInteractor
extension FavoritesInteractorImpl : FavoritesInteractor {
    
}
