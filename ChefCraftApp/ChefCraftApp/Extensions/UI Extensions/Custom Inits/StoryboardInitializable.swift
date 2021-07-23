//
//  StoryboardInitializable.swift
//  ChefCraftApp
//
//  Created by Work on 23.07.2021.
//

import UIKit

protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitializable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func board(_ board: AppStoryboards) -> Self {
        let storyboard = UIStoryboard(name: board.storyboard, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
