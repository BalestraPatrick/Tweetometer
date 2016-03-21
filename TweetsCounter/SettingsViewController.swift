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
    @IBOutlet weak var developedByButton: UIButton!
    @IBOutlet weak var githubButton: UIButton!
    
    let settings = SettingsManager.sharedManager
    let linkOpener = LinkOpener()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsStepper.value = Double(settings.numberOfAnalyzedTweets)
        tweetsStepper.numberFormatter.maximumFractionDigits = 0
        
        developedByButton.layer.cornerRadius = 5.0
        developedByButton.layer.borderColor = UIColor.whiteColor().CGColor
        developedByButton.layer.borderWidth = 1.0
        
        githubButton.layer.cornerRadius = 5.0
        githubButton.layer.borderColor = UIColor.whiteColor().CGColor
        githubButton.layer.borderWidth = 1.0
    }
    
    @IBAction func stepperChanged(sender: ValueStepper) {
        settings.numberOfAnalyzedTweets = Int(sender.value)
    }
    
    @IBAction func developedBy(sender: AnyObject) {
        let url = NSURL(string: Links.developerAddress)!
        let safari = linkOpener.openInSafari(url)
        presentViewController(safari, animated: true, completion: nil)
    }
    
    @IBAction func openGithub(sender: AnyObject) {
        let url = NSURL(string: Links.githubAddress)!
        let safari = linkOpener.openInSafari(url)
        presentViewController(safari, animated: true, completion: nil)
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
