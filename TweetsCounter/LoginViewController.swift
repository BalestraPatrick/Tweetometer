//
//  TwitterLoginViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 11/2/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import TwitterKit
import Crashlytics

public final class LoginViewController: UIViewController {

    @IBOutlet weak var logInButton: TWTRLogInButton!
    weak var coordinator: LoginCoordinatorDelegate!

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Twitter login button initialization
        logInButton.logInCompletion = { [unowned self] session, error in
            if let e = error {
                Answers.logLogin(withMethod: nil, success: false, customAttributes: ["error" : e])
                return print(e)
            }
            Answers.logLogin(withMethod: nil, success: true, customAttributes: nil)
            self.coordinator.dismiss()
        }
    }
}
