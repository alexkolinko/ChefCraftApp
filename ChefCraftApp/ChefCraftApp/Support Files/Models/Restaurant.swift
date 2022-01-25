//
//  Restaurant.swift
//  ChefCraftApp
//
//  Created by kolinko oleksandr on 24.01.2022.
//

import Foundation

// MARK: - Restaurant
struct Restaurant: Codable {
    let id: String
    let name: String
    let isOpen: Bool
    let latitude: Float
    let longitude: Float
}
