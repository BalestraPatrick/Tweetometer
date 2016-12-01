//
//  LoginCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/1/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import Foundation

protocol LoginViewControllerDelegate: class {
    func presentSafari(_ url: URL)
    func openUser(_ user: String)
}

class LoginCoordinator: LoginViewControllerDelegate {

    let controller: LoginViewController
    var childCoordinators = Array<AnyObject>()
    let linkOpener = LinkOpener()

    init(controller: UserDetailViewController) {
        self.controller = controller
    }

    func start() {
        controller.delegate = self
    }

    // MARK: HomeViewControllerDelegate

    func presentSafari(_ url: URL) {
        let safari = linkOpener.openInSafari(url)
        controller.present(safari, animated: true, completion: nil)
    }

    func openUser(_ user: String) {
        linkOpener.coordinator = self
        linkOpener.openUser(user)
    }
}

