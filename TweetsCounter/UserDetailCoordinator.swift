//
//  UserDetailCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 3/12/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

protocol UserDetailViewControllerDelegate: class {
    func presentSafari(_ url: URL)
    func openUser(_ user: String)
}

class UserDetailCoordinator: UserDetailViewControllerDelegate {
    
    let controller: UserDetailViewController
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

