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
                    
                    let mocked_recipes = ChefCraftAllRecipes(id: "1", collectionsRecipes: [
                        ChefCraftCollectionRecipes(id: "8", name: "8 Recipes", image: "breakfast", recipes: [
                            RecipeItem(id: "1", name: "RecipeItem 1"),
                            RecipeItem(id: "2", name: "RecipeItem 2"),
                            RecipeItem(id: "3", name: "RecipeItem 3")
                        ]),
                    ], recipes: [
                        ChefCraftRecipe(id: "2", name: "Second RECIPE", image: "bitmap", description: "Second RECIPE - description",  owner: "Sarah", isLike: false, stars: 3, about: "Second RECIPE - is best recipe", compositions: [
                            RecipeComposition(type: .calories, value: 200),
                            RecipeComposition(type: .ingredients, value: 7),
                            RecipeComposition(type: .totalTime, value: 40)
                        ])
                    ])
                    
                    tested_presenter.viewDataPublisher
                        .subscribe(onNext: { value in
                            if value != nil {
                                data_mirrow.onNext(())
                            }
                        })
                        .disposed(by: bag)
                    
                    tested_interactor.chefCraftRecipes.accept(mocked_recipes)
                    
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
                    let selectModel = Recipe(id: "1", title: "test", image: "test", description: "test", owner: "test", isLike: true, stars: 5, about: "test", compositions: [])
                    
                    tested_presenter.selectCell(model: selectModel)
                    
                    tested_router.action_subj.onCompleted()
                    
                    expect(tested_router.action_subj).last.to(equal(.showRecipeDetails), description: "Expect for calling show recipe details navigation from router according to presenter flow")
                }
            }
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
    
    func showRecipeDetails(details: Recipe) {
        self.action_subj.onNext(.showRecipeDetails)
    }
    
}

// MARK: - MockNavigationAction
private enum MockNavigationAction: String, Equatable {
    case showRecipeDetails
}
