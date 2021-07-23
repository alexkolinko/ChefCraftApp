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
        self.windowConfig(injector: injector)
        return true
    }

    func windowConfig(injector: Container) {
        window?.rootViewController = HomeBuilder.build(injector: injector)
        window?.makeKeyAndVisible()
    }
}

