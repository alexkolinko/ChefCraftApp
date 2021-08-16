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
                    
                    tested_interactor.chefCraftRecipes.accept(mockes.chefCraftAllRecipes)
                    
                    tested_presenter.selectRecipeCell(model: mockes.recipeCellItem)
                    
                    tested_router.action_subj.onCompleted()
                    
                    expect(tested_router.action_subj).last.to(equal(.showRecipeDetails), description: "Expect for calling show recipe details navigation from router according to presenter flow")
                }
                
                it("trigger show showRecipeDetails action with chefCraftRecipes be nil") {
                    
                    tested_interactor.chefCraftRecipes.accept(nil)
                    
                    tested_presenter.selectRecipeCell(model: mockes.recipeCellItem)
                    
                    tested_router.action_subj.onCompleted()
                    
                    expect(tested_router.action_subj).last.to(beNil(), description: "Expect for calling show recipe details navigation from router according to presenter flow")
                }
                
                it("trigger show showCategoryDetails action") {
                    
                    tested_interactor.chefCraftRecipes.accept(mockes.chefCraftAllRecipes)
                    
                    tested_presenter.selectCategoryCell(model: mockes.categoryCellItem)
                    
                    tested_router.action_subj.onCompleted()
                    
                    expect(tested_router.action_subj).last.to(equal(.showCategoryDetails), description: "Expect for calling show category details navigation from router according to presenter flow")
                }
                
                it("trigger show showCategoryDetails action with chefCraftRecipes be nil") {
                    
                    tested_interactor.chefCraftRecipes.accept(nil)
                    
                    tested_presenter.selectCategoryCell(model: mockes.categoryCellItem)
                    
                    tested_router.action_subj.onCompleted()
                    
                    expect(tested_router.action_subj).last.to(beNil(), description: "Expect for calling show category details navigation from router according to presenter flow")
                }

            }
        }
    }
}

private extension HomePresenterTests {
    struct MockedItem {
        var categoryCellItem: HomeViewContent.CategoryCellItem
        var recipeCellItem: HomeViewContent.RecipeCellItem
        var chefCraftAllRecipes: UserRecipes
        
        init() {
            self.categoryCellItem = HomeViewContent.CategoryCellItem(id: "1", title: "test", image: "test", recipes: [])
            self.recipeCellItem = HomeViewContent.RecipeCellItem(id: "1", title: "test", image: "test", description: "test", owner: "test", isLike: true, stars: 5, about: "test", compositions: [])
            self.chefCraftAllRecipes = UserRecipes(id: "1", categoriesRecipes: [
                CategoryRecipes(id: "1", name: "8 Recipes", image: "breakfast", recipes: [
                    Recipe(id: "1", name: "RecipeItem 1", image: "test", description: "test", owner: "test", isLike: true, stars: 3, about: "test", compositions: []),
                    Recipe(id: "2", name: "RecipeItem 2", image: "test", description: "test", owner: "test", isLike: true, stars: 3, about: "test", compositions: []),
                    Recipe(id: "3", name: "RecipeItem 3", image: "test", description: "test", owner: "test", isLike: true, stars: 3, about: "test", compositions: [])
                ]),
                CategoryRecipes(id: "8", name: "8 Recipes", image: "breakfast", recipes: [
                    Recipe(id: "1", name: "RecipeItem 1", image: "test", description: "test", owner: "test", isLike: true, stars: 3, about: "test", compositions: []),
                    Recipe(id: "2", name: "RecipeItem 2", image: "test", description: "test", owner: "test", isLike: true, stars: 3, about: "test", compositions: []),
                    Recipe(id: "3", name: "RecipeItem 3", image: "test", description: "test", owner: "test", isLike: true, stars: 3, about: "test", compositions: [])
                ])
            ], recipes: [
                Recipe(id: "1", name: "Second RECIPE", image: "bitmap", description: "Second RECIPE - description",  owner: "Sarah", isLike: false, stars: 3, about: "Second RECIPE - is best recipe", compositions: [
                    RecipeComposition(type: .calories, value: 200),
                    RecipeComposition(type: .ingredients, value: 7),
                    RecipeComposition(type: .totalTime, value: 40)
                ]),
                Recipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Second RECIPE - description",  owner: "Sarah", isLike: false, stars: 3, about: "Second RECIPE - is best recipe", compositions: [
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
    var chefCraftRecipes = BehaviorRelay<UserRecipes?>(value: nil)
    
}

// MARK: - MockkedRouter: HomeNavigationProtocol
private class MockedRouter: HomeNavigationProtocol {
    
    var action_subj = ReplaySubject<MockNavigationAction>.createUnbounded()
    
    func showCategoryDetails(details: CategoryRecipes) {
        self.action_subj.onNext(.showCategoryDetails)
    }
    
    func showRecipeDetails(details: Recipe) {
        self.action_subj.onNext(.showRecipeDetails)
    }
    
}

// MARK: - MockNavigationAction
private enum MockNavigationAction: String, Equatable {
    case showRecipeDetails
    case showCategoryDetails
}
