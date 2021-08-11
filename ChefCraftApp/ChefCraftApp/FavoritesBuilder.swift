//
//  FavoritesBuilder.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import Foundation
import UIKit
import Swinject

class FavoritesBuilder {
    static func build(injector: Container) -> FavoritesViewController {
        let viewController = FavoritesViewController.board(.Favorites)

        let router = FavoritesRouter(injector: injector)
        router.viewController = viewController
        
        let interactor = FavoritesInteractorImpl()
        
        let presenter = FavoritesPresenter(router: router, interactor: interactor)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
