//
//  HomeCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 3/12/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate: class {
    func pushDetail(controller: UserDetailViewController)
}

class HomeCoordinator: HomeViewControllerDelegate {

    let controller: HomeViewController
    var childCoordinators = Array<AnyObject>()
    
    init(controller: HomeViewController) {
        self.controller = controller
    }
    
    func start() {
        controller.delegate = self
    }
    
    // MARK: HomeViewControllerDelegate
    
    func pushDetail(controller: UserDetailViewController) {
        let userDetailCoordinator = UserDetailCoordinator(controller: controller)
        childCoordinators.append(userDetailCoordinator)
        userDetailCoordinator.start()
    }
}
