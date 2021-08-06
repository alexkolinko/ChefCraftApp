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
    private let disposeBag = DisposeBag()
    
    
    // - Base
    init(router: CategoryRecipesNavigation, interactor: CategoryRecipesInteractor) {
        self.router = router
        self.interactor = interactor
        self.binding()
    }
    
    func popView() {
        self.router.popView()
    }
}

// MARK: - Private logic
private extension CategoryRecipesPresenter {
    
    func binding() {
        self.interactor.categoryData
            .subscribe(onNext: { [weak self] category in
                guard let category = category else { return }
                let categoryRecipes = category.recipes.compactMap { model -> CategoryRecipeCellModel? in
                    return CategoryRecipeCellModel(model: model)
                }
                let section = CategoryRecipesSectionModel(id: "category_recipes_section", items: categoryRecipes)
                self?.viewData.accept(Output(categoryRecipesDataSource: [section], imageCategory: category.image))
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Internal Output
extension CategoryRecipesPresenter {
    
    struct Output {
        let categoryRecipesDataSource: [CategoryRecipesSectionModel]
        let imageCategory: String
    }
}
