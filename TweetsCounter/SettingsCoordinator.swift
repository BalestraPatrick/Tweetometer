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
    func dismiss()
}

final class SettingsCoordinator: SettingsCoordinatorDelegate {

    lazy var settingsViewController: SettingsViewController = {
        return StoryboardScene.Main.settingsViewController()
    }()

    let presenter: Presentr

    var childCoordinators = Array<AnyObject>()

    let parent: UIViewController

    init(parent: UIViewController) {
        self.parent = parent
        self.presenter = Presentr(presentationType: .custom(width: .fluid(percentage: 0.9), height: .fluid(percentage: 0.9), center: .center))
        presenter.transitionType = .coverVertical
        presenter.dismissOnSwipe = true
    }

    func start() {
        settingsViewController.coordinator = self
        parent.customPresentViewController(presenter, viewController: settingsViewController, animated: true, completion: nil)
    }

    // MARK: SettingsCoordinatorDelegate

    func dismiss() {
        settingsViewController.dismiss(animated: true)
    }
}
