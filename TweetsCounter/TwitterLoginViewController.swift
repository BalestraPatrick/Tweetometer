//
//  TwitterLoginViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 11/2/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import TwitterKit

public final class TwitterLoginViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    weak var homeViewController: HomeViewController?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Add login button to view
        let logInButton = TWTRLogInButton { session, error in
            if let e = error {
                self.resultLabel.text = e.localizedFailureReason
            } else {
                if let home = self.homeViewController {
                    home.startRequests()
                }
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
    
}
