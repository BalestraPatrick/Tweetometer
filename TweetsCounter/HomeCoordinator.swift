//
//  HomeCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 3/12/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

protocol HomeCoordinatorDelegate: class {
    func pushDetail(_ controller: UserDetailViewController)
    func presentMenu(_ controller: MenuPopOverViewController)
    func presentLogin()
}

class HomeCoordinator: HomeCoordinatorDelegate {

    let controller: HomeViewController
    var childCoordinators = Array<AnyObject>()
    
    init(controller: HomeViewController) {
        self.controller = controller
    }
    
    func start() {
        controller.coordinator = self
    }
    
    // MARK: HomeCoordinatorDelegate
    
    func pushDetail(_ controller: UserDetailViewController) {
        let userDetailCoordinator = UserDetailCoordinator(controller: controller)
        childCoordinators.append(userDetailCoordinator)
        userDetailCoordinator.start()
    }

    func presentMenu(_ controller: MenuPopOverViewController) {
        let menuCoordinator = MenuCoordinator(parent: self, controller: controller)
        childCoordinators.append(menuCoordinator)
        menuCoordinator.start()
    }

    func presentLogin() {
        let loginCoordinator = LoginCoordinator(parent: controller)
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }

    // Navigation handles here but invoked from the MenuCoordinator.

    func presentSettings() {
        // TODO: remove menu coordinator
        let settingsCoordinator = SettingsCoordinator(parent: controller)
        settingsCoordinator.start()
    }
}
