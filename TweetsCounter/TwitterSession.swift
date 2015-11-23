//
//  TwitterSession.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 11/17/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import TwitterKit

struct TwitterSession {

    var session: TWTRSession? {
        get {
            return self.session
        }
        set (newValue) {
            // Save important data to Keychain
            let username = session?.userName
            let userID = session?.userID
            
            print((session?.userName)! + " just logged in with userID \(userID)")
        }
    }
    
    func handleLogInError(error: NSError) {
        
    }
    
    
}
