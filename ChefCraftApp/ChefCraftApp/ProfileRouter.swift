//
//  ProfileRouter.swift
//  ChefCraftApp
//
//  Created by Work on 13.12.2021.
//  
//

import Foundation

// MARK: - ProfileNavigation
/// Abstract navigation layer for ProfileRouter
protocol ProfileNavigation {}

// MARK: - ProfileRouter
final class ProfileRouter: Router<ProfileViewController>, ProfileNavigation {
}
