//
//  CategoryRecipesPresenterTests.swift
//  ChefCraftAppTests
//
//  Created by Work on 16.08.2021.
//

import Quick
import Nimble
import RxNimble
import RxSwift
import RxCocoa
@testable import ChefCraftApp

// MARK: - CategoryRecipesPresenterTests
class CategoryRecipesPresenterTests: QuickSpec {
    
    override func spec() {
        describe("Cases") {
            var tested_presenter: CategoryRecipesPresenter!
            var tested_interactor: MockedInteractor!
            var tested_router: MockedRouter!
            var bag: DisposeBag!
            
            
            context("for user actions") {
                var data_mirrow: ReplaySubject<Void>!
                let mockes = MockedItem()
                
                beforeEach {
                    tested_interactor = MockedInteractor()
                    tested_router = MockedRouter()
                    tested_presenter = CategoryRecipesPresenter(router: tested_router, interactor: tested_interactor)
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
                
                it("try start mapViewData with categoryData") {
                    
                    tested_presenter.viewData
                        .subscribe(onNext: { value in
                            if value != nil {
                                data_mirrow.onNext(())
                            }
                        })
                        .disposed(by: bag)
                    
                    tested_interactor.categoryData.accept(mockes.categoryRecipes)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }
                    
                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for returning not nil")
                }
                
                it("try start mapViewData with categoryData be nil") {
                    
                    tested_presenter.viewData
                        .subscribe(onNext: { value in
                            if value != nil {
                                data_mirrow.onNext(())
                            }
                        })
                        .disposed(by: bag)
                    
                    tested_interactor.categoryData.accept(nil)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }
                    
                    expect(data_mirrow).last.to(beNil(), description: "Expect for returning nil")
                }
                
                it("trigger show popView action") {
                    
                    tested_presenter.popView()
                    
                    tested_router.action_subj.onCompleted()
                    
                    expect(tested_router.action_subj).last.to(equal(.popView), description: "Expect for calling show pop view navigation from router according to presenter flow")
                }
            }
        }
    }
}

private extension CategoryRecipesPresenterTests {
    struct MockedItem {
        
        var categoryRecipes: CategoryRecipes
        
        init() {
            self.categoryRecipes = CategoryRecipes(id: "1", name: "test", image: "test", recipes: [
                Recipe(id: "1", name: "test", image: "test", description: "test", owner: "test", isLike: true, stars: 1, about: "test", compositions: []),
                Recipe(id: "2", name: "test", image: "test", description: "test", owner: "test", isLike: true, stars: 1, about: "test", compositions: [])
            ])
        }
    }
}

// MARK: - MockedInteractor: CategoryRecipesInteractor
private class MockedInteractor: CategoryRecipesInteractor {
    var categoryData = BehaviorRelay<CategoryRecipes?>(value: nil)
    
}

// MARK: - MockkedRouter: CategoryRecipesNavigation
private class MockedRouter: CategoryRecipesNavigation {
    
    var action_subj = ReplaySubject<MockNavigationAction>.createUnbounded()
    
    func popView() {
        action_subj.onNext(.popView)
    }
    
}

// MARK: - MockNavigationAction
private enum MockNavigationAction: String, Equatable {
    case popView
}
