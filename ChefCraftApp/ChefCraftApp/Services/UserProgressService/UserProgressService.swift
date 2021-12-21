//
//  UserProgressService.swift
//  ChefCraftApp
//
//  Created by Work on 13.12.2021.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - UserProgressServiceProtocol
protocol UserProgressServiceProtocol {
    
    /// Input channel for UserProgressService. If you want to get any response from the service, please fill it with required data
    var input: UserProgressService.Input { get }
    
    /// Output channel from UserProgressService. Should retun observable property with different outputs for user interface elements or logic layers. Details see in struct description
    var output: UserProgressService.Output { get }
}

// MARK: - UserProgressService
final class UserProgressService: UserProgressServiceProtocol {
    
    // - Public propreties
    let input: Input
    let output: Output
    
    // - Private propreties
    private let mockedRecipes = PublishSubject<[Recipe]>()
    private let inputRecipes = PublishSubject<[Recipe]>()
    private let cookedRecipesPerDay = ReplaySubject<Int>.create(bufferSize: 1)
    private let cookedRecipesPerWeek = ReplaySubject<Int>.create(bufferSize: 1)
    private let missedRecipes = ReplaySubject<Int>.create(bufferSize: 1)
    private let needToBeCook = ReplaySubject<Int>.create(bufferSize: 1)
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.input = .init(
            mockedRecipes: self.mockedRecipes.asObserver(),
            recipes: self.inputRecipes.asObserver()
        )
        self.output = .init(
            cookedRecipesPerDay: self.cookedRecipesPerDay.asObservable(),
            cookedRecipesPerWeek: self.cookedRecipesPerWeek.asObservable(),
            missedRecipes: self.missedRecipes.asObservable(),
            needToBeCook: self.needToBeCook.asObservable()
        )
        
        self.binding()
    }
}

// MARK: UserProgressService + Private
private extension UserProgressService {
 
    func binding() {
        
        Observable.combineLatest(self.mockedRecipes, self.inputRecipes)
            .subscribe(onNext: { [weak self] mockedRecipes, inputRecipes in
                self?.handleInput(mockedRecipes, inputRecipes)
            })
            .disposed(by: self.disposeBag)
    }
    
    func handleInput(_ mockedRecipes: [Recipe], _ inputRecipes: [Recipe]) {
        self.getCookedRecipiesPerDay(recipies: inputRecipes)
        self.getCookedRecipiesPerWeek(recipies: inputRecipes)
        self.getMissedAndNeedToCookRecipes(inputRecipes, mockedRecipes: mockedRecipes)
    }
    
    func getCookedRecipiesPerDay(recipies: [Recipe]) {
        let cookedRecipes = recipies.filter({ $0.cooked == true })
        let dates = cookedRecipes.map({ $0.dateOfCooked.toDate() })
        let todayCooked = dates.filter { Calendar.current.isDateInToday($0!) }
        self.cookedRecipesPerDay.onNext(todayCooked.count)
    }
    
    func getCookedRecipiesPerWeek(recipies: [Recipe]) {
        let today = Date()
        let week = today.datesOfWeek().map({ $0.getShortDate() })
        let cookedDates = recipies.compactMap({ $0.dateOfCooked.toDate()?.getShortDate() })
        let result = cookedDates.filter( {week.contains($0) == true} )
        
        self.cookedRecipesPerWeek.onNext(result.count)
    }
    
    func getMissedAndNeedToCookRecipes(_ recipies: [Recipe], mockedRecipes: [Recipe]) {
        let cookedIDs = recipies.filter({ $0.cooked == true }).map({ $0.id })
        let mockedIDs = mockedRecipes.map({ $0.id })
        
        guard let maxIndex = cookedIDs.compactMap({ mockedIDs.firstIndex(of: $0) }).max() else { return }
        let coverageCooked = maxIndex + 1
        let missed = coverageCooked - cookedIDs.count
        let needed = (mockedRecipes.count - coverageCooked) + missed
        
        self.missedRecipes.onNext(missed)
        self.needToBeCook.onNext(needed)
        
    }
}
