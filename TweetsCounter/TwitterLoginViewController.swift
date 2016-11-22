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
    
    weak var homeViewController: HomeViewController?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Add login button to view
        let logInButton = TWTRLogInButton { session, error in
            if let e = error {
                return print(e)
            } else if let home = self.homeViewController {
                home.startRequests()
            }
            self.dismiss(animated: true, completion: nil)
        }

        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
