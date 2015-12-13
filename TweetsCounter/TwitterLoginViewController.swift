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
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let logInButton = TWTRLogInButton { (session, error) in
//            print("error \(error)")
//            print("session \(session)")
//            if let e = error {
//                self.resultLabel.text = e.localizedFailureReason;
//            } else {
//                self.dismissViewControllerAnimated(true, completion: nil)
//            }
        }

        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
        
    }
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
