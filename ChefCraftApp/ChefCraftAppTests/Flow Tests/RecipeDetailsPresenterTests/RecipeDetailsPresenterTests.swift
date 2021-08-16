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
            
            context("for user actions") {
                var data_mirrow: ReplaySubject<Void>!
                let mockes = MockedItem()
                
                beforeEach {
                    tested_interactor = MockedInteractor()
                    tested_router = MockedRouter()
                    tested_presenter = RecipeDetailsPresenter(router: tested_router, interactor: tested_interactor)
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
                    
                    tested_interactor.recipeData.accept(mockes.cellItem)
                    tested_interactor.recipeFavorite.accept(mockes.like)
                    tested_interactor.recipeRating.accept(mockes.rating)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }
                    
                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for returning not nil")
                }
                
                it("try start mapViewData with recipes and recipeFavorite be nil") {
                    
                    tested_presenter.viewDataPublisher
                        .subscribe(onNext: { value in
                            if value != nil {
                                data_mirrow.onNext(())
                            }
                        })
                        .disposed(by: bag)
                    
                    tested_interactor.recipeData.accept(mockes.cellItem)
                    
                    tested_interactor.recipeFavorite.accept(nil)
                    tested_interactor.recipeRating.accept(mockes.rating)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }
                    
                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for returning not nil")
                }
                
                it("try start mapViewData with recipes and recipeRating be nil") {
                    
                    tested_presenter.viewDataPublisher
                        .subscribe(onNext: { value in
                            if value != nil {
                                data_mirrow.onNext(())
                            }
                        })
                        .disposed(by: bag)
                    
                    tested_interactor.recipeData.accept(mockes.cellItem)
                    
                    tested_interactor.recipeFavorite.accept(mockes.like)
                    tested_interactor.recipeRating.accept(nil)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }
                    
                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for returning not nil")
                }
                
                it("trigger selectRating") {
                    tested_presenter.selectRating(mockes.rating)
                    
                    tested_interactor.action.onCompleted()
                    
                    expect(tested_interactor.action).last.to(equal(.updateRating), description: "Expect for the storage to update according to the presenter flow")
                }
                
                it("trigger selectLike") {
                    tested_presenter.selectLike(mockes.isLike)
                    
                    tested_interactor.action.onCompleted()
                    
                    expect(tested_interactor.action).last.to(equal(.updateLike), description: "Expect for the storage to update according to the presenter flow")
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

private extension RecipeDetailsPresenterTests {
    struct MockedItem {
        var rating: Int
        var like: String
        var isLike: Bool
        var cellItem: Recipe
        
        init() {
            self.rating = 3
            self.like = "1"
            self.isLike = true
            self.cellItem = Recipe(id: "test", name: "test", image: "test", description: "test", owner: "test", isLike: true, stars: 5, about: "test", compositions: [RecipeComposition(type: .calories, value: 150), RecipeComposition(type: .ingredients, value: 4), RecipeComposition(type: .totalTime, value: 30)])
        }
    }
}

// MARK: - MockedInteractor: RecipeDetailsInteractor
private class MockedInteractor: RecipeDetailsInteractor {
    var recipeData = BehaviorRelay<Recipe?>(value: nil)
    var recipeRating = BehaviorRelay<Int?>(value: nil)
    var recipeFavorite = BehaviorRelay<String?>(value: nil)
    let action = ReplaySubject<MockInteractorAction>.createUnbounded()
    
    func updateRating(_ rating: Int) {
        self.action.onNext(.updateRating)
    }
    
    func updateLike(_ isLike: Bool) {
        self.action.onNext(.updateLike)
    }
    
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

// MARK: - MockInteractorAction
private enum MockInteractorAction {
    case updateRating
    case updateLike
}

