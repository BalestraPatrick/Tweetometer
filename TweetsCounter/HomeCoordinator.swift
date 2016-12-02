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

    func presentLogin() {
        let loginCoordinator = LoginCoordinator(parent: controller)
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
}
