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
    
    let settings = SettingsManager.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsStepper.value = Double(settings.numberOfAnalyzedTweets)
        tweetsStepper.numberFormatter.maximumFractionDigits = 0
    }
    
    @IBAction func stepperChanged(sender: ValueStepper) {
        settings.numberOfAnalyzedTweets = Int(sender.value)
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
