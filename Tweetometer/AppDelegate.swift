//
//  AppDelegate.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/19/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import TweetometerKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private lazy var appCoordinator = AppCoordinator(window: self.window!)
    private var dependencies = [DependencyInitializer]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        dependencies = [
            appCoordinator,
            TwitterKitInitializer()
        ]
        dependencies.forEach { $0.start() }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let twitterInitializer = dependencies.compactMap({ $0 as? TwitterKitInitializer }).first {
            return twitterInitializer.application(app, open:url, options: options)
        }
        return false
    }
}

