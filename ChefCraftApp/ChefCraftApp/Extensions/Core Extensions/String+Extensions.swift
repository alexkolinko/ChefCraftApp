//
//  String+Extensions.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import Foundation

// MARK: - String
extension String {


    var snakeCased: String {
        let pattern = "([a-z0-9])([A-Z])"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        
        let text = regex?.stringByReplacingMatches(
            in: self,
            options: [],
            range: NSRange(location: .zero, length: self.count),
            withTemplate: "$1_$2"
        )
        
        return text?.lowercased() ?? self
    }
    
    var strippingTextInParentheses: String {
        let pattern = "\\((.*?)\\)"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: .zero, length: count)
        
        let text = regex?.stringByReplacingMatches(
            in: self,
            options: [],
            range: range, withTemplate: ""
        )
        
        return text ?? self
    }
}
