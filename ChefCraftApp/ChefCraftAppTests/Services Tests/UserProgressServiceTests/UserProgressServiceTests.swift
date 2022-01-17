//
//  UserProgressServiceTests.swift
//  ChefCraftAppTests
//
//  Created by Work on 17.01.2022.
//

import Quick
import Nimble
import RxNimble
import RxSwift
import MapKit

@testable import ChefCraftApp

class UserProgressServiceTests: QuickSpec {
    
    override func spec() {
        describe("Cases") {
            var tested_service: UserProgressService!
            
            var data_mirrow: ReplaySubject<Void>!
            
            var bag: DisposeBag!
            
            // MARK: - Cases for happy flow
            context("for unhappy flow") {

                beforeEach {
                    tested_service = .init()
                    data_mirrow = ReplaySubject<Void>.createUnbounded()
                    bag = .init()
                }
                
                afterEach {
                    tested_service = nil
                    bag = nil
                }
                
                it("try to get missed recipes") {
                    
                    tested_service.input.mockedRecipes.onNext([])
                    tested_service.input.recipes.onNext([])
                    
                    tested_service.output.missedRecipes
                        .subscribe(onNext: { _ in
                            data_mirrow.onNext(())
                        }).disposed(by: bag)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }

                    expect(data_mirrow).last.to(beNil(), description: "Expect for success data binding according to presenter flow")
                }
                
                it("try to get needToBeCook") {
                    tested_service.input.mockedRecipes.onNext([])
                    tested_service.input.recipes.onNext([])
                    
                    tested_service.output.needToBeCook
                        .subscribe(onNext: { _ in
                            data_mirrow.onNext(())
                        }).disposed(by: bag)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }

                    expect(data_mirrow).last.to(beNil(), description: "Expect for success data binding according to presenter flow")
                }
            }
            
            // MARK: - Cases for handleBuildedRoute method
            context("for handleInput method") {
                beforeEach {
                    tested_service = .init()
                    data_mirrow = ReplaySubject<Void>.createUnbounded()
                    bag = .init()
                }
                
                afterEach {
                    tested_service = nil
                    bag = nil
                }
                
                it("try to get cooked recipes per day") {
                    
                    tested_service.input.mockedRecipes.onNext(Mock.mockedRecipes)
                    tested_service.input.recipes.onNext(Mock.inputRecipes)
                    
                    tested_service.output.cookedRecipesPerDay
                        .subscribe(onNext: { _ in
                            data_mirrow.onNext(())
                        }).disposed(by: bag)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }

                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for success data binding according to presenter flow")
                }
                
                it("try to get cooked recipes per week") {
                    
                    tested_service.input.mockedRecipes.onNext(Mock.mockedRecipes)
                    tested_service.input.recipes.onNext(Mock.inputRecipes)
                    
                    tested_service.output.cookedRecipesPerWeek
                        .subscribe(onNext: { _ in
                            data_mirrow.onNext(())
                        }).disposed(by: bag)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }

                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for success data binding according to presenter flow")
                }
                
                it("try to get missed recipes") {
                    
                    tested_service.input.mockedRecipes.onNext(Mock.mockedRecipes)
                    tested_service.input.recipes.onNext(Mock.inputRecipes)
                    
                    tested_service.output.missedRecipes
                        .subscribe(onNext: { _ in
                            data_mirrow.onNext(())
                        }).disposed(by: bag)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }

                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for success data binding according to presenter flow")
                }
                
                it("try to get need to be cook") {
                    
                    tested_service.input.mockedRecipes.onNext(Mock.mockedRecipes)
                    tested_service.input.recipes.onNext(Mock.inputRecipes)
                    
                    tested_service.output.needToBeCook
                        .subscribe(onNext: { _ in
                            data_mirrow.onNext(())
                        }).disposed(by: bag)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        data_mirrow.onCompleted()
                    }

                    expect(data_mirrow).last.toNot(beNil(), description: "Expect for success data binding according to presenter flow")
                }
            }
        }
    }
}

// MARK: - Mock
private struct Mock {
    
    static let mockedRecipes: [Recipe] = [
        .init(id: "1", name: "First RECIPE", image: "bitmap", description: "test", owner: "test", isLike: true, cooked: true, dateOfCooked: "17 Jan 2022, 16:06", stars: 4, about: "test", compositions: [
            RecipeComposition(type: .calories, value: 150),
            RecipeComposition(type: .ingredients, value: 5),
            RecipeComposition(type: .totalTime, value: 30)
        ]),
        .init(id: "2", name: "Second RECIPE", image: "bitmap", description: "test", owner: "test", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "test", compositions: [
            RecipeComposition(type: .calories, value: 150),
            RecipeComposition(type: .ingredients, value: 5),
            RecipeComposition(type: .totalTime, value: 30)
        ])
    ]
    
    static let inputRecipes: [Recipe] = [
        .init(id: "1", name: "First RECIPE", image: "bitmap", description: "test", owner: "Smith", isLike: true, cooked: true, dateOfCooked: "17 Jan 2022, 16:06", stars: 4, about: "test", compositions: [
            RecipeComposition(type: .calories, value: 150),
            RecipeComposition(type: .ingredients, value: 5),
            RecipeComposition(type: .totalTime, value: 30)
        ]),
        .init(id: "2", name: "Second RECIPE", image: "bitmap", description: "test", owner: "test", isLike: true, cooked: false, dateOfCooked: "", stars: 4, about: "test", compositions: [
            RecipeComposition(type: .calories, value: 150),
            RecipeComposition(type: .ingredients, value: 5),
            RecipeComposition(type: .totalTime, value: 30)
        ])
    ]
    
}
