//
//  Tweets.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/1/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import TwitterKit


enum AuthenticationError: ErrorType {
    case NotAuthenticated
    case Unknown
}

struct Tweets {
    
    func checkSessionUserID() throws -> String {
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            return userID
        } else {
            throw AuthenticationError.NotAuthenticated
        }
    }
    
    func requestTweets(userID: String) {
        let client = TWTRAPIClient(userID: userID)
        client.loadUserWithID(userID) { (user, error) in
            guard error == nil && user != nil else {
                // TODO: Handle error
                print(error)
                return
            }
            // Download profile image of the logged in user
//            ProfileImageDownloader().downloadProfileImageURL((user?.profileImageURL)!)
        }
    }
}