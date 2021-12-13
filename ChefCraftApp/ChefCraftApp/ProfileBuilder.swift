//
//  ProfileBuilder.swift
//  ChefCraftApp
//
//  Created by Work on 13.12.2021.
//  
//

import Foundation
import UIKit
import Swinject

final class ProfileBuilder {
    static func build(injector: Container) -> ProfileViewController {
        let viewController = ProfileViewController.board(.Profile)

        let router = ProfileRouter(injector: injector)
        router.viewController = viewController
        
        let interactor = ProfileInteractorImpl(
            userProgressService: injector.resolve(UserProgressService.self)!,
            databaseProvider: injector.resolve(DatabaseRecipeProvider.self)!
        )
        
        let presenter = ProfilePresenterImpl(router: router, interactor: interactor)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
