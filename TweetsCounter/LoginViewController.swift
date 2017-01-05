//
//  TwitterLoginViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 11/2/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import TwitterKit
import TweetometerKit

public final class LoginViewController: UIViewController {

    @IBOutlet weak var logInButton: TWTRLogInButton!
    weak var coordinator: LoginCoordinatorDelegate!

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Twitter login button initialization
        logInButton.logInCompletion = { [unowned self] session, error in
            if let e = error {
                Analytics.shared.track(event: .login(success: false, error: ["error" : e]))
                return print(e)
            }
            Analytics.shared.track(event: .login(success: true, error: nil))
            self.coordinator.dismiss()
        }
    }
}
