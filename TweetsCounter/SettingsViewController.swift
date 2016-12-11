//
//  SettingsViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 1/22/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import ValueStepper

final class SettingsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tweetsStepper: ValueStepper!
    @IBOutlet weak var twitterClientControl: UISegmentedControl!
    
    @IBOutlet weak var developedByButton: UIButton!
    @IBOutlet weak var githubButton: UIButton!
    
    let settings = SettingsManager.sharedManager
    let linkOpener = LinkOpener()
    weak var coordinator: SettingsCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsStepper.value = Double(settings.numberOfAnalyzedTweets)
        tweetsStepper.numberFormatter.maximumFractionDigits = 0
        
        twitterClientControl.selectedSegmentIndex = TwitterClient.toIndex(settings.preferredTwitterClient)
        
        developedByButton.layer.cornerRadius = 5.0
        developedByButton.layer.borderColor = UIColor.white.cgColor
        developedByButton.layer.borderWidth = 1.0
        
        githubButton.layer.cornerRadius = 5.0
        githubButton.layer.borderColor = UIColor.white.cgColor
        githubButton.layer.borderWidth = 1.0

        twitterClientControl.setEnabled(linkOpener.isTwitterAvailable, forSegmentAt: 1)
        twitterClientControl.setEnabled(linkOpener.isTweetbotAvailable, forSegmentAt: 2)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func stepperChanged(_ sender: ValueStepper) {
        settings.numberOfAnalyzedTweets = Int(sender.value)
    }
    
    @IBAction func clientChanged(_ sender: UISegmentedControl) {
        settings.preferredTwitterClient = TwitterClient.fromIndex(sender.selectedSegmentIndex)
    }
    
    @IBAction func developedBy(_ sender: AnyObject) {
        let url = URL(string: Links.developerAddress)!
        let safari = linkOpener.openInSafari(url)
        present(safari, animated: true, completion: nil)
    }
    
    @IBAction func openGithub(_ sender: AnyObject) {
        let url = URL(string: Links.githubAddress)!
        let safari = linkOpener.openInSafari(url)
        present(safari, animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
