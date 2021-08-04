//
//  CategoryRecipesPresenter.swift
//  ChefCraftApp
//
//  Created by Work on 04.08.2021.
//

import RxSwift
import RxCocoa

class CategoryRecipesPresenter {
    
    // - Internal Propreties
    let viewData = BehaviorRelay<Output?>(value: nil)
    
    // - Private Properties
    private let router: CategoryRecipesNavigation
    private let interactor: CategoryRecipesInteractor
    private let category: HomeViewContent.CategoryCellItem
    private let disposeBag = DisposeBag()
    
    
    // - Base
    init(router: CategoryRecipesNavigation, interactor: CategoryRecipesInteractor, category: HomeViewContent.CategoryCellItem) {
        self.router = router
        self.interactor = interactor
        self.category = category
        self.binding()
    }
    
    func popView() {
        self.router.popView()
    }
    
    // - Private functions
    private func binding() {
        let categoryRecipes = self.category.recipes.compactMap { model -> CategoryRecipeCellModel? in
            return CategoryRecipeCellModel(model: model)
        }
        let section = CategoryRecipesSectionModel(id: "category_recipes_section", items: categoryRecipes)
        self.viewData.accept(Output(categoryRecipesDataSource: [section], imageCategory: self.category.image))
    }
}

extension CategoryRecipesPresenter {
    
    struct Output {
        let categoryRecipesDataSource: [CategoryRecipesSectionModel]
        let imageCategory: String
    }
}
