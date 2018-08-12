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
        self.source.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
