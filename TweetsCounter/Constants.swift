//
//  Constants.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/31/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation

struct TwitterEndpoints {
    
    let timeline: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.twitter.com"
        components.path = "/1.1/statuses/home_timeline.json"
        return components
    }()
    
    var timelineURL: String {
        return timeline.string!
    }
    
    let profile: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.twitter.com"
        components.path = "users/show.json"
        return components
    }()
    
}

struct Links {
    static let developerAddress = "http://www.patrickbalestra.com"
    static let githubAddress = "http://www.github.com/BalestraPatrick/Tweetometer"
}

enum TableViewCell: String {
    case UserCellIdentifier = "UserCell"
    case MenuPopOverCellIdentifier = "MenuPopOverCell"
    case TweetCellIdentifier = "TweetCell"
    case UserDetailsCellIdentifier = "UserDetailsCell"
}

let cacheName = "TweetsCounter"

struct StashCacheIdentifier {
    static let profilePicture = "UserProfilePicture"
}

struct ViewControllerIdentifier {
    static let twitterLogin = "TwitterLogin"
}
