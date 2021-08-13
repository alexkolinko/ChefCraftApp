//
//  Array+Extensions.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import Foundation

// MARK: - Array
extension Array {
    
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}

// MARK: - Array where Element: Equatable
extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
}
