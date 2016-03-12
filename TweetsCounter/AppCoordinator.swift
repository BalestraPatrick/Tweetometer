//
//  AppCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 3/11/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject {
    
    let window: UIWindow
    lazy var rootViewController: UINavigationController = {
        return self.window.rootViewController as! UINavigationController
    }()
    
    var childCoordinators = Array<AnyObject>()
    
    init(window: UIWindow) {
        // Grab the initial view controller from Storyboard
        self.window = window
        self.childCoordinators = []
    }
    
    func start() {
        // Grab view controller instance already instantiated by Storyboard from the hierarchy
        if let visible = rootViewController.visibleViewController, let homeViewController = visible as? HomeViewController {
            let homeCoordinator = HomeCoordinator(controller: homeViewController)
            childCoordinators.append(homeCoordinator)
            homeCoordinator.start()
        }
    }
    
    func showSafariViewController(url: NSURL) {
        
    }

}
