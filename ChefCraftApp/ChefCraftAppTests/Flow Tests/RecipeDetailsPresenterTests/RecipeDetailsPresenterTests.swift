//
//  RecipeDetailsPresenterTests.swift
//  ChefCraftAppTests
//
//  Created by Work on 04.08.2021.
//

import Quick
import Nimble
import RxNimble
import RxSwift
import RxCocoa
@testable import ChefCraftApp

// MARK: - RecipeDetailsPresenterTests
class RecipeDetailsPresenterTests: QuickSpec {
    
    override func spec() {
        describe("Cases") {
            var tested_presenter: RecipeDetailsPresenter!
            var tested_interactor: MockedInteractor!
            var tested_router: MockedRouter!
            var bag: DisposeBag!
            let mocked_details = HomeViewContent.RecipeCellItem(id: "test", title: "test", image: "test", description: "test", owner: "test", isLike: true, stars: 5, about: "test", compositions: [RecipeComposition(type: .calories, value: 150), RecipeComposition(type: .ingredients, value: 4), RecipeComposition(type: .totalTime, value: 30)])
            
            
            context("for user actions") {
                var data_mirrow: ReplaySubject<Void>!
                
                beforeEach {
                    tested_interactor = MockedInteractor()
                    tested_router = MockedRouter()
                    tested_presenter = RecipeDetailsPresenter(router: tested_router, interactor: tested_interactor, details: mocked_details)
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
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }
                    
                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for returning not nil")
                }
                
                it("trigger show popView action") {
                    
                    tested_presenter.popView()
                    
                    tested_router.action_subj.onCompleted()
                    
                    expect(tested_router.action_subj).last.to(equal(.popView), description: "Expect for calling show recipe details navigation from router according to presenter flow")
                }
            }
        }
    }
}

// MARK: - MockedInteractor: RecipeDetailsInteractor
private class MockedInteractor: RecipeDetailsInteractor {
    var chefCraftRecipes = BehaviorRelay<ChefCraftAllRecipes?>(value: nil)
    
}

// MARK: - MockkedRouter: RecipeDetailsNavigation
private class MockedRouter: RecipeDetailsNavigation {
    
    var action_subj = ReplaySubject<MockNavigationAction>.createUnbounded()
    
    func popView() {
        self.action_subj.onNext(.popView)
    }
    
}

// MARK: - MockNavigationAction
private enum MockNavigationAction: String, Equatable {
    case popView
}

