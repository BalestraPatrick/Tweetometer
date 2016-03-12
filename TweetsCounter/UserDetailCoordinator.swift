//
//  UserDetailCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 3/12/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

protocol UserDetailViewControllerDelegate: class {
    func presentSafari(url: NSURL)
    func openUser(user: String)
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
    
    func presentSafari(url: NSURL) {
        // TODO: fix status bar color in SFSafariViewController
        let safari = linkOpener.openInSafari(url)
        controller.presentViewController(safari, animated: true, completion: nil)
    }
    
    func openUser(user: String) {
        linkOpener.openUser(user)
    }
}

