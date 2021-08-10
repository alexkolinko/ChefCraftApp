//
//  HomeBuilder.swift
//  ChefCraftApp
//
//  Created by Work on 23.07.2021.
//

import Foundation
import UIKit
import Swinject

class HomeBuilder {
    static func build(injector: Container) -> HomeViewController {
        let viewController = HomeViewController.board(.Home)

        let router = HomeRouter(injector: injector)
        router.viewController = viewController
        
        let interactor = HomeInteractorImpl(homeMessageDatabaseProvider: injector.resolve(DatabaseUserRecipesProvider.self)!)
        
        let presenter = HomePresenter(router: router, interactor: interactor)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
