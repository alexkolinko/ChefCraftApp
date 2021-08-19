//
//  AppDelegate.swift
//  ChefCraftApp
//
//  Created by Alexandr on 22.07.2021.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // - Internal Properties
    var window: UIWindow?
    
    // - Private Service Properties
    private var dependenciesHolder: DependenciesHolder!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        self.dependenciesHolder = DependenciesHolder()
        let injector = dependenciesHolder.injector()
        self.configureGeneralUI()
        self.windowConfig(injector: injector)
        return true
    }
}

// MARK: - private extension AppDelegate
private extension AppDelegate {
    
    func windowConfig(injector: Container) {
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = RootBuilder.build(injector: injector)
        window?.makeKeyAndVisible()
    }
    
    /// Set up global UI settings for navigation bar
    func configureGeneralUI() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .white

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
    }
}

