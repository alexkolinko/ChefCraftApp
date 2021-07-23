//
//  AppStoryboards.swift
//  ChefCraftApp
//
//  Created by Work on 23.07.2021.
//

import Foundation

enum AppStoryboards: String, CaseIterable {
    
    case Home
  
    var storyboard: String {
        return self.rawValue + "View"
    }
}
