//
//  SettingsCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/11/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

protocol SettingsCoordinatorDelegate: class {
    func dismiss()
}

final class SettingsCoordinator: SettingsCoordinatorDelegate {

    lazy var settingsViewController: SettingsViewController = {
        return StoryboardScene.Main.settingsViewController()
    }()

    var childCoordinators = Array<AnyObject>()

    let parent: UIViewController

    init(parent: UIViewController) {
        self.parent = parent
    }

    func start() {
        settingsViewController.coordinator = self
        parent.present(settingsViewController, animated: true)
    }

    // MARK: SettingsCoordinatorDelegate

    func dismiss() {
//        loginViewController.dismiss(animated: true)
    }
}
