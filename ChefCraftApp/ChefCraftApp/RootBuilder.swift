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
        let profileViewController = UINavigationController(rootViewController: ProfileBuilder.build(injector: injector))
        let mapsViewController = UINavigationController(rootViewController: RecipesMapBuilder.build(injector: injector))
        
        
        let homeTabItem = UITabBarItem(title: "Home", image: UIImage(named: "icHome")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icHomeSelected")?.withRenderingMode(.alwaysOriginal))
        
        let favoritesTabItem = UITabBarItem(title: "Favorites", image: UIImage(named: "icFavorites")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icFavoritesSelected")?.withRenderingMode(.alwaysOriginal))
        
        let profileTabItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray), selectedImage: UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysOriginal))
        
        let mapsTabItem = UITabBarItem(title: "Maps", image: UIImage(systemName: "map.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray), selectedImage: UIImage(systemName: "map.fill")?.withRenderingMode(.alwaysOriginal))
        
        homeTabItem.tag = RootTabItemTags.home.rawValue
        favoritesTabItem.tag = RootTabItemTags.favorites.rawValue
        profileTabItem.tag = RootTabItemTags.profile.rawValue
        mapsTabItem.tag = RootTabItemTags.maps.rawValue
        
        homeViewController.tabBarItem = homeTabItem
        favoritesViewController.tabBarItem = favoritesTabItem
        profileViewController.tabBarItem = profileTabItem
        mapsViewController.tabBarItem = mapsTabItem
        
        return [
            homeViewController,
            favoritesViewController,
            profileViewController,
            mapsViewController
        ]
    }
}
