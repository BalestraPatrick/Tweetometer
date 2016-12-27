//
//  MenuCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/11/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import TweetometerKit

protocol MenuCoordinatorDelegate: class {
    func refreshTimeline()
    func logout()
    func presentSettings()
}

class MenuCoordinator: Coordinator, MenuCoordinatorDelegate {

    var childCoordinators = Array<AnyObject>()
    
    let controller: MenuPopOverViewController
    let parentCoordinator: HomeCoordinator
    let linkOpener = LinkOpener()

    init(parent: HomeCoordinator, controller: MenuPopOverViewController) {
        self.parentCoordinator = parent
        self.controller = controller
        linkOpener.coordinator = self
    }

    func start() {
        controller.coordinator = self
    }

    // MARK: Coordinator

    func presentSafari(_ url: URL) {
        let safari = linkOpener.openInSafari(url)
        controller.present(safari, animated: true, completion: nil)
    }

    // MARK: MenuCoordinatorDelegate

    func logout() {
        DataManager.logOut()
        controller.dismiss(animated: true)
        parentCoordinator.presentLogin()
    }

    func refreshTimeline() {
        controller.dismiss(animated: true)
        parentCoordinator.refreshTimeline()
    }

    func presentSettings() {
        controller.dismiss(animated: true)
        parentCoordinator.presentSettings()
    }
}
