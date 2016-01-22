//
//  DismissFromSettingsSegue.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 1/22/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

class DismissFromSettingsSegue: UIStoryboardSegue {
    override func perform() {
        self.sourceViewController.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
