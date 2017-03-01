//
//  UserDetailCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 3/12/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import Foundation

protocol UserDetailCoordinatorDelegate: class {
    func open(user: String)
    func open(hashtag: String)
}

class UserDetailCoordinator: Coordinator, UserDetailCoordinatorDelegate {

    var childCoordinators = [AnyObject]()
    
    let controller: UserDetailViewController
    let linkOpener = LinkOpener()
    
    init(controller: UserDetailViewController) {
        self.controller = controller
        linkOpener.coordinator = self
    }

    func start() {
        controller.coordinator = self
    }
    
    // MARK: HomeViewControllerDelegate
    
    func presentSafari(_ url: URL) {
        let safari = linkOpener.openInSafari(url)
        controller.present(safari, animated: true, completion: nil)
    }
    
    func open(user: String) {
        linkOpener.open(user: user)
    }

    func open(hashtag: String) {
        linkOpener.open(hashtag: hashtag)
    }

    func open(tweet: String) {
        linkOpener.open(tweet: tweet)
    }
}
