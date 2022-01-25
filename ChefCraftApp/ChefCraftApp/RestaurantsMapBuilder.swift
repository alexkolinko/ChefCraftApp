//
//  RestaurantsMapBuilder.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//  
//

import Foundation
import UIKit
import Swinject

final class RestaurantsMapBuilder {
    static func build(injector: Container) -> RestaurantsMapViewController {
        let viewController = RestaurantsMapViewController.board(.RestaurantsMap)

        let router = RestaurantsMapRouter(injector: injector)
        router.viewController = viewController
        
        let interactor = RestaurantsMapInteractorImpl()
        
        let presenter = RestaurantsMapPresenterImpl(router: router, interactor: interactor)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
