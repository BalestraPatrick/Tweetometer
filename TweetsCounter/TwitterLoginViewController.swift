//
//  TwitterLoginViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 11/2/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import TwitterKit

public class TwitterLoginViewController: UIViewController {

    var twitterSession = TwitterSession()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let store = Twitter.sharedInstance().sessionStore
        let lastSession = store.session()
        print("User ID of the last session: \(lastSession?.userID)")

        let logInButton = TWTRLogInButton { (session, error) in
            if let e = error {
                self.twitterSession.handleLogInError(e)
            }
            self.twitterSession.session = session
        }
        
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

    }
}
