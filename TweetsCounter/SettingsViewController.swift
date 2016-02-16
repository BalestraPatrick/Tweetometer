//
//  SettingsViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 1/22/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
