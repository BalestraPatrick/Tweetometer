//
//  Constants.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/31/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation

struct TwitterAPI {
    let baseURL = "https://api.twitter.com/"
    let version = "1.1"

    let userTimelinePath = "/statuses/user_timeline"
    
    var URL: String {
        get {
            return baseURL + version
        }
    }
    
    var userTimelineURL: String {
        get {
            return URL + userTimelinePath
        }
    }
}


struct TableViewCell {
    let user = "UserCell"
}