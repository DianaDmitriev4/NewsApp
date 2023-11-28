//
//  AppDelegate.swift
//  newsApp
//
//  Created by User on 27.11.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, 
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let tabBar = TabBarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window {
            window.rootViewController = tabBar
            window.makeKeyAndVisible()
        }
        
        return true
    }
}

