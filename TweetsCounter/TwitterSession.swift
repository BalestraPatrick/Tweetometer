//
//  Tweets.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/1/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import TwitterKit

enum TwitterRequestError: Error {
    case notAuthenticated
    case unknown
}

final class TwitterSession {
    
    static var client: TWTRAPIClient?
    var user: TWTRUser?
    
    ///  Check the session user ID to see if there is an user logged in.
    static func isUserLoggedIn() -> Bool {
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            client = TWTRAPIClient(userID: userID)
            return true
        }
        return false
    }

    
}
