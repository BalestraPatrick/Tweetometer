//
//  MenuCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/11/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

protocol MenuCoordinatorDelegate: class {
    func presentSettings()
}

class MenuCoordinator: MenuCoordinatorDelegate {

    let controller: MenuPopOverViewController
    // The MenuCoordinator can't exist without a parent coordinator because it's presented through a popOver.
    let parentCoordinator: HomeCoordinator
    var childCoordinators = Array<AnyObject>()

    init(parent: HomeCoordinator, controller: MenuPopOverViewController) {
        self.parentCoordinator = parent
        self.controller = controller
    }

    func start() {
        controller.coordinator = self
    }

    // MARK: MenuCoordinatorDelegate

    func presentSettings() {
        controller.dismiss(animated: true)
        parentCoordinator.presentSettings()
    }

//    func pushDetail(_ controller: UserDetailViewController) {
//        let userDetailCoordinator = UserDetailCoordinator(controller: controller)
//        childCoordinators.append(userDetailCoordinator)
//        userDetailCoordinator.start()
//    }
//
//    func presentMenu() {
//        let menuCoordinator = MenuCoordinator()
//        childCoordinators.append(menuCoordinator)
//        menuCoordinator.start()
//    }
//
//    func presentLogin() {
//        let loginCoordinator = LoginCoordinator(parent: controller)
//        childCoordinators.append(loginCoordinator)
//        loginCoordinator.start()
//    }
}
