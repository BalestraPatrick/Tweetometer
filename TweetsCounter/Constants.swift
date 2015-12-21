//
//  Constants.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/31/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation

struct TwitterEndpoints {
    
    let userTimelineComponents: NSURLComponents = {
        let components = NSURLComponents()
        components.scheme = "https"
        components.host = "api.twitter.com"
        components.path = "/1.1/statuses/user_timeline"
        return components
    }()
    
}

let cacheName = "TweetsCounter"

struct StashCacheIdentifier {
    static let profilePicture = "UserProfilePicture"
}

struct TableViewCellIdentifier {
    static let user = "UserCell"
}

struct ViewControllerIdentifier {
    static let twitterLogin = "TwitterLogin"
}