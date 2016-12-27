//
//  SettingsCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/11/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import Presentr

protocol SettingsCoordinatorDelegate: class {
    func presentEmailSupport()
    func presentTwitterSupport()
    func presentAbout()
    func presentGithub()
    func dismiss()
}

final class SettingsCoordinator: Coordinator, SettingsCoordinatorDelegate {

    lazy var controller: SettingsViewController = {
        return StoryboardScene.Main.settingsViewController()
    }()

    var childCoordinators = Array<AnyObject>()

    let presenter: Presentr
    let parent: UIViewController
    let linkOpener = LinkOpener()

    init(parent: UIViewController) {
        self.parent = parent
        self.presenter = Presentr(presentationType: .custom(width: .fluid(percentage: 0.9), height: .fluid(percentage: 0.9), center: .center))
        linkOpener.coordinator = self
        presenter.transitionType = .coverVertical
        presenter.dismissOnSwipe = true
    }

    func start() {
        controller.coordinator = self
        parent.customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
    }

    // MARK: Coordinator

    func presentSafari(_ url: URL) {
        let safari = linkOpener.openInSafari(url)
        controller.present(safari, animated: true, completion: nil)
    }

    // MARK: SettingsCoordinatorDelegate

    func presentEmailSupport() {

    }

    func presentTwitterSupport() {
        
    }

    func presentAbout() {
        let url = URL(string: Links.developer)!
        let safari = linkOpener.openInSafari(url)
        controller.present(safari, animated: true, completion: nil)
    }

    func presentGithub() {
        let url = URL(string: Links.github)!
        let safari = linkOpener.openInSafari(url)
        controller.present(safari, animated: true, completion: nil)
    }

    func dismiss() {
        controller.dismiss(animated: true)
    }
}
