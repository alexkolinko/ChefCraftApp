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
    
    typealias OutputResult = UserProgressService.Output.Result
    
    // - Public propreties
    let input: Input
    let output: Output
    
    // - Private propreties
    private let mockedRecipes = PublishSubject<[Recipe]>()
    private let inputRecipes = PublishSubject<[Recipe]>()
    private let result = ReplaySubject<OutputResult>.create(bufferSize: 1)
    private let disposeBag = DisposeBag()
    
    init() {
        self.input = .init(
            mockedRecipes: self.mockedRecipes.asObserver(),
            recipes: self.inputRecipes.asObserver()
        )
        self.output = .init(result: self.result)
        
        self.binding()
    }
}

// MARK: UserProgressService + Private
private extension UserProgressService {
 
    func binding() {
        
        Observable.combineLatest(self.mockedRecipes, self.inputRecipes)
            .map({ OutputResult(
                cookedRecipesPerDay: self.calculateCookedRecipiesPerDay(recipies: $1),
                cookedRecipesPerWeek: self.calculateCookedRecipiesPerWeek(recipies: $1),
                missedRecipes: self.calculateMissedRecipes($0, mockedRecipes: $1),
                needToBeCook: self.calculateNeedToCookRecipes($0, mockedRecipes: $1)
            ) })
            .subscribe(onNext: { [weak self] value in
                self?.result.onNext(value)
            })
            .disposed(by: self.disposeBag)
    }
    
    func calculateCookedRecipiesPerDay(recipies: [Recipe]) -> Int {
        let cookedRecipes = recipies.filter({ $0.cooked == true })
        let dates = cookedRecipes.compactMap({ $0.dateOfCooked.toDate() })
        let todayCooked = dates.filter { Calendar.current.isDateInToday($0) }
        return todayCooked.count
    }
    
    func calculateCookedRecipiesPerWeek(recipies: [Recipe]) -> Int {
        let week = Date().datesOfWeek().map({ $0.getShortDate() })
        let cookedDates = recipies.compactMap({ $0.dateOfCooked.toDate()?.getShortDate() })
        let result = cookedDates.filter( { week.contains($0) } )
        return result.count
    }
    
    func calculateMissedRecipes(_ recipies: [Recipe], mockedRecipes: [Recipe]) -> Int {
        let cookedIDs = recipies.filter({ $0.cooked == true }).map({ $0.id })
        let mockedIDs = mockedRecipes.map({ $0.id })
        let coverageCooked = cookedIDs.compactMap({ mockedIDs.firstIndex(of: $0) }).max() ?? 0 + 1
        return coverageCooked - cookedIDs.count
        
    }
    
    func calculateNeedToCookRecipes(_ recipies: [Recipe], mockedRecipes: [Recipe]) -> Int {
        let cookedIDs = recipies.filter({ $0.cooked == true }).map({ $0.id })
        let mockedIDs = mockedRecipes.map({ $0.id })
        let coverageCooked = cookedIDs.compactMap({ mockedIDs.firstIndex(of: $0) }).max() ?? 0 + 1
        let missed = coverageCooked - cookedIDs.count
        return (mockedRecipes.count - coverageCooked) + missed
        
    }
}
