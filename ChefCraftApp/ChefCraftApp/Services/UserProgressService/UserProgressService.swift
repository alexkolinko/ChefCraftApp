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
    private let inputRecipes = PublishSubject<[Recipe]>()
    
    private let cookedRecipesOutput = PublishSubject<Int>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.input = .init(recipes: self.inputRecipes.asObserver())
        self.output = .init(cookedRecipes: self.cookedRecipesOutput.asObservable())
        
        self.binding()
    }
}

// MARK: UserProgressService + Private
private extension UserProgressService {
 
    func binding() {
        
        self.inputRecipes
            .subscribe(onNext: { [weak self] value in
                self?.handleInput(recipies: value)
            })
            .disposed(by: self.disposeBag)
    }
    
    func handleInput(recipies: [Recipe]) {
        let cookedRecipes = recipies.filter({ $0.cooked == true })
        let datee = cookedRecipes.map({ $0.dateOfCooked })
        self.cookedRecipesOutput.onNext(cookedRecipes.count)
    }
}
