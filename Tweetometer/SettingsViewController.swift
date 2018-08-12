//
//  SettingsViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 1/22/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import TweetometerKit
import ValueStepper

final class SettingsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tweetsStepper: ValueStepper!
    @IBOutlet weak var twitterClientControl: UISegmentedControl!
    
    @IBOutlet weak var twitterSupportButton: UIButton!
    @IBOutlet weak var emailSupportButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var githubButton: UIButton!

    let settings = Settings.shared
    let linkOpener = LinkOpener()
    weak var coordinator: SettingsCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsStepper.value = Double(settings.maximumNumberOfTweets)
        tweetsStepper.numberFormatter.maximumFractionDigits = 0
        
        twitterClientControl.selectedSegmentIndex = TwitterClient.toIndex(settings.preferredTwitterClient)

        twitterSupportButton.layer.cornerRadius = 5.0
        emailSupportButton.layer.cornerRadius = 5.0
        aboutButton.layer.cornerRadius = 5.0
        githubButton.layer.cornerRadius = 5.0

        view.backgroundColor = .menuDarkBlue()

        twitterClientControl.setEnabled(linkOpener.isTwitterAvailable, forSegmentAt: 1)
        twitterClientControl.setEnabled(linkOpener.isTweetbotAvailable, forSegmentAt: 2)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func stepperChanged(_ sender: ValueStepper) {
        settings.maximumNumberOfTweets = Int(sender.value)
    }
    
    @IBAction func clientChanged(_ sender: UISegmentedControl) {
        settings.preferredTwitterClient = TwitterClient.fromIndex(sender.selectedSegmentIndex)
    }

    // MARK: Navigation

    @IBAction func emailSupport(_ sender: Any) {
        coordinator.presentEmailSupport()
    }
    
    @IBAction func twitterSupport(_ sender: Any) {
        coordinator.presentTwitterSupport()
    }

    @IBAction func developedBy(_ sender: Any) {
        coordinator.presentAbout()
    }
    
    @IBAction func openGithub(_ sender: Any) {
        coordinator.presentGithub()
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
        coordinator.dismiss()
    }
}
