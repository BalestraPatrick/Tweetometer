//
//  MenuCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/11/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import TweetometerKit
import Social

protocol MenuCoordinatorDelegate: class {
    func refreshTimeline()
    func share()
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
        controller.dismiss(animated: false)
        let safari = linkOpener.openInSafari(url)
        controller.present(safari, animated: true, completion: nil)
    }

    // MARK: MenuCoordinatorDelegate

    func refreshTimeline() {
        controller.dismiss(animated: false)
        parentCoordinator.refreshTimeline()
    }

    func share() {
        controller.dismiss(animated: false)
        guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) else {
            return parentCoordinator.controller.presentAlert(title: "No Twitter account available")
        }

        if let twitterSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
            twitterSheet.add(URL(string: "https://www.patrickbalestra.com/Tweetometer"))
            twitterSheet.add(parentCoordinator.controller.tableView.topUsersImage)
            parentCoordinator.controller.present(twitterSheet, animated: true)
        }
    }

    func logout() {
        DataManager.logOut()
        controller.dismiss(animated: false)
        parentCoordinator.presentLogin()
    }

    func presentSettings() {
        controller.dismiss(animated: false)
        parentCoordinator.presentSettings()
    }
}
