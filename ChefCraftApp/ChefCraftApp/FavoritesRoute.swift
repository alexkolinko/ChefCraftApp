//
//  FavoritesRoute.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import Foundation

protocol FavoritesRoute {
    var FavoritesTransition: Transition { get }
    
    func showFavorites()
}

extension FavoritesRoute where Self: RouterProtocol {
    
    func showFavorites() {
        let viewController = FavoritesBuilder.build(injector: injector)
        open(viewController, transition: FavoritesTransition)
    }
}
