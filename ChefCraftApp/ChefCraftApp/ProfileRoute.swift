//
//  ProfileRoute.swift
//  ChefCraftApp
//
//  Created by Work on 13.12.2021.
//  
//

import Foundation

protocol ProfileRoute {
    var ProfileTransition: Transition { get }
    
    func showProfile()
}

extension ProfileRoute where Self: RouterProtocol {
    
    func showProfile() {
        let viewController = ProfileBuilder.build(injector: injector)
        open(viewController, transition: ProfileTransition)
    }
}
