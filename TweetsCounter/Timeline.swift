//
//  Timeline.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/2/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit

struct Timeline {
    
    /// Users sorted by the highest number of tweets
    var users: [User]
    
    init(users: [User]) {
        self.users = users
    }
}

