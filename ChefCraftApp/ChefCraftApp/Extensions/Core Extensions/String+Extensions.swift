//
//  String+Extensions.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import Foundation
import UIKit

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
    /// Calculate needed height for label
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    /// Calculates needed height for label with additional line spacing (left aligned + word wrap)
    func height(withConstrainedWidth width: CGFloat, font: UIFont, lineSpacing spacing: CGFloat) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = NSTextAlignment.left
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font, .paragraphStyle: paragraphStyle], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    /// Calculate needed width for label
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
