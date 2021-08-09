//
//  RecipeDetailsInteractor.swift
//  ChefCraftApp
//
//  Created by Work on 29.07.2021.
//

import RxCocoa
import RxSwift

// MARK: - RecipeDetailsInteractor
/// Abstract logic layer for RecipeDetailsInteractorImpl
protocol RecipeDetailsInteractor {
    
    var recipeData: BehaviorRelay<HomeViewContent.RecipeCellItem?> { get set }
    
    func updateStorage(rating: Int)
    
}

// MARK: - RecipeDetailsInteractorImpl
/// Implementation class for RecipeDetailsInteractor
class RecipeDetailsInteractorImpl {
    
    // - Internal Properties
    var recipeData = BehaviorRelay<HomeViewContent.RecipeCellItem?>(value: nil)
    
    // - Private Properties
    private let details: HomeViewContent.RecipeCellItem
    private let databaseProvider: DatabaseChefCraftRecipeProviderProtocol
    private let disposeBag = DisposeBag()
    
    init(databaseProvider: DatabaseChefCraftRecipeProviderProtocol, details: HomeViewContent.RecipeCellItem) {
        self.databaseProvider = databaseProvider
        self.details = details
        self.binding()
    }
}

// MARK: - Private logic
private extension RecipeDetailsInteractorImpl {
    func binding() {
        #warning("If selected first recipe with id = 1 - it is success. If selected second recipe with id = 2 - getting failure (objectNotExists)")
        self.databaseProvider.getChefCraftRecipe(id: details.id)
            .subscribe(onSuccess: {[weak self] recipe in
                let data = HomeViewContent.RecipeCellItem(id: recipe.id, title: recipe.name, image: recipe.image, description: recipe.description, owner: recipe.owner, isLike: recipe.isLike, stars: recipe.stars, about: recipe.about, compositions: recipe.compositions)
                self?.recipeData.accept(data)
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - RecipeDetailsInteractorImpl: RecipeDetailsInteractor
extension RecipeDetailsInteractorImpl : RecipeDetailsInteractor {
 
    func updateStorage(rating: Int) {
        let newModel = ChefCraftRecipe(id: details.id, name: details.title, image: details.image, description: details.description, owner: details.owner, isLike: details.isLike, stars: rating, about: details.about, compositions: details.compositions)
        self.databaseProvider.saveChefCraftRecipe(with: newModel).subscribe().disposed(by: self.disposeBag)
    }
}
