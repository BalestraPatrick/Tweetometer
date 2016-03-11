//
//  AppCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 3/11/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject {
    
    let navigationViewController: UINavigationController
    
    var childCoordinators = Array<AppCoordinator>()
    
    init(navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    
    func start() {
        print(navigationViewController)
    }
    
    func showSafariViewController(url: NSURL) {
        
    }

}
