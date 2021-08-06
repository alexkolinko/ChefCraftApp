//
//  CategoryRecipesInteractor.swift
//  ChefCraftApp
//
//  Created by Work on 04.08.2021.
//

import RxCocoa
import RxSwift

// MARK: - CategoryRecipesInteractor
/// Abstract logic layer for CategoryRecipesInteractorImpl
protocol CategoryRecipesInteractor {
    
    var categoryData: BehaviorRelay<HomeViewContent.CategoryCellItem?> { get set }
}

// MARK: - CategoryRecipesInteractorImpl
/// Implementation class for CategoryRecipesInteractor
class CategoryRecipesInteractorImpl {
    
    // - Internal Properties
    var categoryData = BehaviorRelay<HomeViewContent.CategoryCellItem?>(value: nil)
    
    // - Private Properties
    private let category: HomeViewContent.CategoryCellItem
    private let disposeBag = DisposeBag()
    
    init(category: HomeViewContent.CategoryCellItem) {
        self.category = category
        self.binding()
    }
}

private extension CategoryRecipesInteractorImpl {
    func binding() {
        self.categoryData.accept(self.category)
    }
}

// MARK: - CategoryRecipesInteractorImpl: CategoryRecipesInteractor
extension CategoryRecipesInteractorImpl: CategoryRecipesInteractor {
    
    
}
