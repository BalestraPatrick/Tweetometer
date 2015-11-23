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

struct TableViewCell {
    let user = "UserCell"
}