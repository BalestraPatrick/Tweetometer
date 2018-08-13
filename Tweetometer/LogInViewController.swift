//
//  LogInViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 11/2/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import TweetometerKit
import TwitterKit

public final class LogInViewController: UIViewController {

    @IBOutlet weak var logInButton: TWTRLogInButton!
    weak var coordinator: LoginCoordinatorDelegate!

    public override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func logIn() {
        logInButton.logInCompletion = { [unowned self] session, error in
            if let e = error {
                Analytics.shared.track(event: .login(success: false, error: ["error": e]))
                return print(e)
            }
            self.coordinator.dismiss()
        }
    }
}
