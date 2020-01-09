//
//  AppDelegate.swift
//  CitySearch
//
//  Created by Hernan G. Gonzalez on 09/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let model = MainViewViewModel()
        let main = MainViewController(model: model)
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: main)
        window?.makeKeyAndVisible()

        model.prepareForUse()
        return true
    }
}

