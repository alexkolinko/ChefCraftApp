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

    func windowConfig(injector: Container) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        let mainView = HomeBuilder.build(injector: injector)
        navController.viewControllers = [mainView]
        self.window!.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    
    /// Set up global UI settings for navigation bar
    func configureGeneralUI() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
    }
}

