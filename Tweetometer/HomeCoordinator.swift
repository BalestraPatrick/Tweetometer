//
//  HomeCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 3/12/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import TweetometerKit

protocol HomeCoordinatorDelegate: class {
    var twitterService: TwitterSession { get }
    func pushDetail(_ controller: UserDetailViewController)
    func presentMenu(_ controller: MenuPopOverViewController)
    func presentLogin()
}

class HomeCoordinator: Coordinator, HomeCoordinatorDelegate {

    var childCoordinators = [AnyObject]()

    let controller: HomeViewController
    let twitterService: TwitterSession
    let linkOpener = LinkOpener()
    
    init(controller: HomeViewController, twitterService: TwitterSession) {
        self.controller = controller
        self.twitterService = twitterService
        linkOpener.coordinator = self
    }

    func start() {
        controller.coordinator = self
        presentLoginIfNeeded()
    }

    // MARK: Coordinator
    
    func presentSafari(_ url: URL) {
        let safari = linkOpener.openInSafari(url)
        controller.present(safari, animated: true, completion: nil)
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

    func presentSettings() {
        let settingsCoordinator = SettingsCoordinator(parent: controller)
        childCoordinators.append(settingsCoordinator)
        settingsCoordinator.start()
    }

    // MARK: Internal Methods

    private func presentLoginIfNeeded() {
        guard twitterService.isUserLoggedIn() == false else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.presentLogin()
        }
    }
}
