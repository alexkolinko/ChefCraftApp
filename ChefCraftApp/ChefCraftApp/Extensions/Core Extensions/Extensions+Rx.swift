//
//  Extensions+Rx.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import RxSwift
import RxCocoa
import CoreLocation
 
// MARK: - OptionalType
public protocol OptionalType {
    associatedtype Wrapped
    
    var optional: Wrapped? { get }
}

// MARK: - Optional: OptionalType
extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

// MARK: - Observable where Element: OptionalType
extension Observable where Element: OptionalType {
    
    func ignoreNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}
