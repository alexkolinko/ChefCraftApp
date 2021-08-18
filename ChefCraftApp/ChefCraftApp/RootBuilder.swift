//
//  RootBuilder.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import Foundation
import UIKit
import Swinject

// MARK: - RootBuilder
class RootBuilder {
    
    static func build(injector: Container) -> RootViewController {
        
        let tabBarController = RootViewController.board(.Root)

        let router = RootRouter(injector: injector)
        router.viewController = tabBarController
        
        let interactor = RootInteractor()
        
        let presenter = RootPresenter(router: router, interactor: interactor)
        
        tabBarController.presenter = presenter
        
        tabBarController.setViewControllers(self.buildViewControllers(injector: injector), animated: false)
        
        tabBarController.selectedIndex = RootTabItemTags.home.rawValue
        tabBarController.tabBar.unselectedItemTintColor = .gray
        
        return tabBarController
    }
    
    private static func buildViewControllers(injector: Container) -> [UIViewController] {
        // - Child View Controlllers init
        let homeViewController = UINavigationController(rootViewController: HomeBuilder.build(injector: injector))
        let favoritesViewController = UINavigationController(rootViewController: FavoritesBuilder.build(injector: injector))
        
        let homeTabItem = UITabBarItem(title: "tabBar.home.item.title".localized, image: UIImage(named: Asset.Assets.icHome.name)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: Asset.Assets.icHomeSelected.name)?.withRenderingMode(.alwaysOriginal))
        
        let favoritesTabItem = UITabBarItem(title: "tabBar.favorites.item.title".localized, image: UIImage(named: Asset.Assets.icFavorites.name)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: Asset.Assets.icFavoritesSelected.name)?.withRenderingMode(.alwaysOriginal))
        
        homeTabItem.tag = RootTabItemTags.home.rawValue
        favoritesTabItem.tag = RootTabItemTags.favorites.rawValue
        
        homeViewController.tabBarItem = homeTabItem
        favoritesViewController.tabBarItem = favoritesTabItem
        
        return [
            homeViewController,
            favoritesViewController
        ]
    }
}
