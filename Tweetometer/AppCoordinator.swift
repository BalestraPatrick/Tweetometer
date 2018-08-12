//
//  AppCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 3/11/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    func presentSafari(_ url: URL)
}

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    let linkOpener = LinkOpener()

    var childCoordinators = [AnyObject]()

    lazy var rootViewController: UINavigationController = {
        return self.window.rootViewController as! UINavigationController
    }()
    
    init(window: UIWindow) {
        // Grab the initial view controller from Storyboard
        let initialViewController = StoryboardScene.Main.initialViewController()
        window.rootViewController = initialViewController
        self.window = window
        self.childCoordinators = []
        linkOpener.coordinator = self
    }

    func start() {
        // Grab view controller instance already instantiated by Storyboard from the hierarchy
        if let visible = rootViewController.visibleViewController, let homeViewController = visible as? HomeViewController {
            let homeCoordinator = HomeCoordinator(controller: homeViewController)
            childCoordinators.append(homeCoordinator)
            homeCoordinator.start()
        }
    }

    // MARK: Coordinator

    func presentSafari(_ url: URL) {
        let safari = linkOpener.openInSafari(url)
        rootViewController.present(safari, animated: true, completion: nil)
    }
}
