//
//  Tweets.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/1/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import TwitterKit


enum TwitterError: ErrorType {
    case NotAuthenticated
    case Unknown
}

struct Tweets {

    let request = TweetsRequest()
    
    func startFetching() throws -> String {
        var client: TWTRAPIClient

        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            client = TWTRAPIClient(userID: userID)
            return ""
        } else {
            client = TWTRAPIClient()
            throw TwitterError.NotAuthenticated
        }
    }
}