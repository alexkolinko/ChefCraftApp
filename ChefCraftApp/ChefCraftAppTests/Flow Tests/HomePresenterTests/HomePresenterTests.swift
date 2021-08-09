//
//  HomePresenterTests.swift
//  ChefCraftAppTests
//
//  Created by Work on 28.07.2021.
//

import Quick
import Nimble
import RxNimble
import RxSwift
import RxCocoa
@testable import ChefCraftApp

// MARK: - HomePresenterTests
class HomePresenterTests: QuickSpec {
    
    override func spec() {
        describe("Cases") {
            var tested_presenter: HomePresenter!
            var tested_interactor: MockedInteractor!
            var tested_router: MockedRouter!
            var bag: DisposeBag!
            
            
            context("for user actions") {
                var data_mirrow: ReplaySubject<Void>!
                let mockes = MockedItem()
                
                beforeEach {
                    tested_interactor = MockedInteractor()
                    tested_router = MockedRouter()
                    tested_presenter = HomePresenter(router: tested_router, interactor: tested_interactor)
                    data_mirrow = ReplaySubject<Void>.createUnbounded()
                    bag = DisposeBag()
                    
                }
                
                afterEach {
                    tested_interactor = nil
                    tested_router = nil
                    tested_presenter = nil
                    data_mirrow = nil
                    bag = nil
                }
                
                it("try start mapViewData with recipes") {
                    
                    tested_presenter.viewDataPublisher
                        .subscribe(onNext: { value in
                            if value != nil {
                                data_mirrow.onNext(())
                            }
                        })
                        .disposed(by: bag)
                    
                    tested_interactor.chefCraftRecipes.accept(mockes.chefCraftAllRecipes)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }
                    
                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for returning not nil")
                }
                
                it("try start mapViewData without recipes") {
                    
                    tested_presenter.viewDataPublisher
                        .subscribe(onNext: { value in
                            if value != nil {
                                data_mirrow.onNext(())
                            }
                        })
                        .disposed(by: bag)
                    
                    tested_interactor.chefCraftRecipes.accept(nil)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }
                    
                    expect(data_mirrow).last.to(beNil(), description: "Expect for returning nil")
                }
                
                it("trigger show showRecipeDetails action") {
                    
                    tested_presenter.selectRecipeCell(model: mockes.recipeCellItem)
                    
                    tested_router.action_subj.onCompleted()
                    
                    expect(tested_router.action_subj).last.to(equal(.showRecipeDetails), description: "Expect for calling show recipe details navigation from router according to presenter flow")
                }
                
                it("trigger show showCategoryDetails action") {
                    
                    tested_presenter.selectCategoryCell(model: mockes.categoryCellItem)
                    
                    tested_router.action_subj.onCompleted()
                    
                    expect(tested_router.action_subj).last.to(equal(.showCategoryDetails), description: "Expect for calling show category details navigation from router according to presenter flow")
                }

            }
        }
    }
}

private extension HomePresenterTests {
    struct MockedItem {
        var categoryCellItem: HomeViewContent.CategoryCellItem
        var recipeCellItem: HomeViewContent.RecipeCellItem
        var chefCraftAllRecipes: ChefCraftAllRecipes
        
        init() {
            self.categoryCellItem = HomeViewContent.CategoryCellItem(id: "1", title: "test", image: "test", recipes: [])
            self.recipeCellItem = HomeViewContent.RecipeCellItem(id: "1", title: "test", image: "test", description: "test", owner: "test", isLike: true, stars: 5, about: "test", compositions: [])
            self.chefCraftAllRecipes = ChefCraftAllRecipes(id: "1", collectionsRecipes: [
                ChefCraftCollectionRecipes(id: "8", name: "8 Recipes", image: "breakfast", recipes: [
                    ChefCraftRecipe(id: "1", name: "RecipeItem 1", image: "test", description: "test", owner: "test", isLike: true, stars: 3, about: "test", compositions: []),
                    ChefCraftRecipe(id: "2", name: "RecipeItem 2", image: "test", description: "test", owner: "test", isLike: true, stars: 3, about: "test", compositions: []),
                    ChefCraftRecipe(id: "3", name: "RecipeItem 3", image: "test", description: "test", owner: "test", isLike: true, stars: 3, about: "test", compositions: [])
                ]),
            ], recipes: [
                ChefCraftRecipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Second RECIPE - description",  owner: "Sarah", isLike: false, stars: 3, about: "Second RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 200),
                    RecipeComposition(type: .ingredients, value: 7),
                    RecipeComposition(type: .totalTime, value: 40)
                ])
            ])
        }
    }
}

// MARK: - MockedInteractor: HomeInteractor
private class MockedInteractor: HomeInteractor {
    var chefCraftRecipes = BehaviorRelay<ChefCraftAllRecipes?>(value: nil)
    
}

// MARK: - MockkedRouter: HomeNavigationProtocol
private class MockedRouter: HomeNavigationProtocol {
    
    var action_subj = ReplaySubject<MockNavigationAction>.createUnbounded()
    
    func showRecipeDetails(details: HomeViewContent.RecipeCellItem) {
        self.action_subj.onNext(.showRecipeDetails)
    }
    
    func showCategoryDetails(details: HomeViewContent.CategoryCellItem) {
        self.action_subj.onNext(.showCategoryDetails)
    }
    
}

// MARK: - MockNavigationAction
private enum MockNavigationAction: String, Equatable {
    case showRecipeDetails
    case showCategoryDetails
}
