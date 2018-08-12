//
//  SettingsCoordinator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/11/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import MessageUI
import Presentr

protocol SettingsCoordinatorDelegate: class {
    func presentEmailSupport()
    func presentTwitterSupport()
    func presentAbout()
    func presentGithub()
    func dismiss()
}

final class SettingsCoordinator: NSObject, Coordinator, SettingsCoordinatorDelegate {

    lazy var controller: SettingsViewController = {
        return StoryboardScene.Main.settingsViewController()
    }()

    lazy var mailController: MFMailComposeViewController = {
        let mail = MFMailComposeViewController()
        mail.setSubject("Tweetometer Support Request")
        mail.setToRecipients(["me@patrickbalestra.com"])
        return mail
    }()

    var childCoordinators = [AnyObject]()

    let presenter = Presentr(presentationType: .custom(width: .fluid(percentage: 0.9), height: .fluid(percentage: 0.8), center: .center))
    let parent: UIViewController
    let linkOpener = LinkOpener()

    init(parent: UIViewController) {
        self.parent = parent
        super.init()
        linkOpener.coordinator = self
        presenter.transitionType = .coverVertical
        presenter.dismissOnSwipe = true
        presenter.cornerRadius = 10.0
    }

    func start() {
        controller.coordinator = self
        parent.customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
    }

    // MARK: Coordinator

    func presentSafari(_ url: URL) {
        let safari = linkOpener.openInSafari(url)
        controller.present(safari, animated: true)
    }

    // MARK: SettingsCoordinatorDelegate

    func presentEmailSupport() {
        guard MFMailComposeViewController.canSendMail() else { return }
//        mailController.mailComposeDelegate = self
        controller.present(mailController, animated: true)
    }

    func presentTwitterSupport() {
        let url = URL(string: Links.twitter)!
        let safari = linkOpener.openInSafari(url)
        controller.present(safari, animated: true)
    }

    func presentAbout() {
        let url = URL(string: Links.developer)!
        let safari = linkOpener.openInSafari(url)
        controller.present(safari, animated: true)
    }

    func presentGithub() {
        let url = URL(string: Links.github)!
        let safari = linkOpener.openInSafari(url)
        controller.present(safari, animated: true)
    }

    func dismiss() {
        controller.dismiss(animated: true)
    }
}

// MARK: MFMailComposeViewControllerDelegate

//extension SettingsCoordinator: MFMailComposeViewControllerDelegate {
//
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true)
//    }
//}
