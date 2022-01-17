//
//  FavoritesPresenterTests.swift
//  ChefCraftAppTests
//
//  Created by Work on 17.08.2021.
//

import Quick
import Nimble
import RxNimble
import RxSwift
import RxCocoa
@testable import ChefCraftApp

// MARK: - FavoritesPresenterTests
class FavoritesPresenterTests: QuickSpec {
    
    override func spec() {
        describe("Cases") {
            var tested_presenter: FavoritesPresenter!
            var tested_interactor: MockedInteractor!
            var tested_router: MockedRouter!
            var bag: DisposeBag!
            
            context("for user actions") {
                var data_mirrow: ReplaySubject<Void>!
                let mockes = MockedItem()
                
                beforeEach {
                    tested_interactor = MockedInteractor()
                    tested_router = MockedRouter()
                    tested_presenter = FavoritesPresenter(router: tested_router, interactor: tested_interactor)
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

                    tested_presenter.viewData
                        .subscribe(onNext: { value in
                            if value != nil {
                                data_mirrow.onNext(())
                            }
                        })
                        .disposed(by: bag)

                    tested_interactor.recipesData.accept(mockes.recipes)
                    tested_interactor.favoritesRecipes.accept(mockes.favoritesRecipes)
                    tested_interactor.ratingRecipes.accept(mockes.ratingRecipes)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }

                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for returning not nil")
                }
                
                it("try start mapViewData with recipes empty") {

                    tested_presenter.viewData
                        .subscribe(onNext: { value in
                            if value != nil {
                                data_mirrow.onNext(())
                            }
                        })
                        .disposed(by: bag)

                    tested_interactor.recipesData.accept([])
                    tested_interactor.favoritesRecipes.accept(mockes.favoritesRecipes)
                    tested_interactor.ratingRecipes.accept(mockes.ratingRecipes)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }

                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for returning not nil")
                }
                
                it("try start mapViewData with favorite recipes empty") {

                    tested_presenter.viewData
                        .subscribe(onNext: { value in
                            if value != nil {
                                data_mirrow.onNext(())
                            }
                        })
                        .disposed(by: bag)

                    tested_interactor.recipesData.accept(mockes.recipes)
                    tested_interactor.favoritesRecipes.accept([])
                    tested_interactor.ratingRecipes.accept(mockes.ratingRecipes)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }

                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for returning not nil")
                }
                
                it("try start mapViewData with rating recipes empty") {

                    tested_presenter.viewData
                        .subscribe(onNext: { value in
                            if value != nil {
                                data_mirrow.onNext(())
                            }
                        })
                        .disposed(by: bag)

                    tested_interactor.recipesData.accept(mockes.recipes)
                    tested_interactor.favoritesRecipes.accept(mockes.favoritesRecipes)
                    tested_interactor.ratingRecipes.accept([])

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }

                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for returning not nil")
                }
                
                it("try start mapViewData with !!!!") {

                    tested_presenter.viewData
                        .subscribe(onNext: { value in
                            if value != nil {
                                data_mirrow.onNext(())
                            }
                        })
                        .disposed(by: bag)

                    tested_interactor.recipesData.accept(mockes.recipes)
                    tested_interactor.favoritesRecipes.accept(mockes.favoritesRecipes)
                    tested_interactor.ratingRecipes.accept([])

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }

                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for returning not nil")
                }
            }
        }
    }
}

private extension FavoritesPresenterTests {
    struct MockedItem {
        var recipes: [Recipe]
        var ratingRecipes: [Recipe]
        var favoritesRecipes: [String]
        
        init() {
            self.recipes = [
                Recipe(id: "1", name: "test", image: "test", description: "test", owner: "test", isLike: true, cooked: false, dateOfCooked: "", stars: 5, about: "test", compositions: [RecipeComposition(type: .calories, value: 150), RecipeComposition(type: .ingredients, value: 4), RecipeComposition(type: .totalTime, value: 30)]),
                Recipe(id: "2", name: "test", image: "test", description: "test", owner: "test", isLike: true, cooked: false, dateOfCooked: "", stars: 5, about: "test", compositions: [RecipeComposition(type: .calories, value: 150), RecipeComposition(type: .ingredients, value: 4), RecipeComposition(type: .totalTime, value: 30)])
            ]
            self.ratingRecipes = [
                Recipe(id: "2", name: "test", image: "test", description: "test", owner: "test", isLike: true, cooked: false, dateOfCooked: "", stars: 6, about: "test", compositions: [RecipeComposition(type: .calories, value: 150), RecipeComposition(type: .ingredients, value: 4), RecipeComposition(type: .totalTime, value: 30)])
            ]
            self.favoritesRecipes = ["2"]
        }
    }
}

// MARK: - MockedInteractor: FavoritesInteractor
private class MockedInteractor: FavoritesInteractor {
    var recipesData = BehaviorRelay<[Recipe]>(value: [])
    var favoritesRecipes = BehaviorRelay<[String]>(value: [])
    var ratingRecipes = BehaviorRelay<[Recipe]>(value: [])
}

// MARK: - MockkedRouter: FavoritesNavigation
private class MockedRouter: FavoritesNavigation {
    
}

//// MARK: - MockInteractorAction
//private enum MockInteractorAction {
//    case updateRating
//    case updateLike
//}

