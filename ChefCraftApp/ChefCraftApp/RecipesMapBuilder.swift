//
//  RecipesMapBuilder.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//  
//

import Foundation
import UIKit
import Swinject

final class RecipesMapBuilder {
    static func build(injector: Container) -> RecipesMapViewController {
        let viewController = RecipesMapViewController.board(.RecipesMap)

        let router = RecipesMapRouter(injector: injector)
        router.viewController = viewController
        
        let interactor = RecipesMapInteractorImpl()
        
        let presenter = RecipesMapPresenterImpl(router: router, interactor: interactor)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
