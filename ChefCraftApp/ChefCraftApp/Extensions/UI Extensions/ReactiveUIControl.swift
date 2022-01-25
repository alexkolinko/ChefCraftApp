//
//  ReactiveUIControl.swift
//  ChefCraftApp
//
//  Created by kolinko oleksandr on 24.01.2022.
//

import RxCocoa
import RxSwift

// MARK: - ObservableType + withPrevious
extension ObservableType {
    
    func withPrevious(startWith first: Element) -> Observable<(Element, Element)> {
        return scan((first, first)) { ($0.1, $1) }.skip(1)
    }
}
