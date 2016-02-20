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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetsStepper.numberFormatter.maximumFractionDigits = 0
        applyStyle()
    }
    
    @IBAction func stepperChanged(sender: ValueStepper) {
        print(String(sender.value))
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
