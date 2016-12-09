//
//  Timeline.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/2/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation

class Timeline {
    
    /// Users sorted by the highest number of tweets
    var users = [User]()

    /// The Id of the oldest retrieved tweet.
    var maxID: String? = nil

}

