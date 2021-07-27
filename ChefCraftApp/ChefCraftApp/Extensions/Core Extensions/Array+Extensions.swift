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
