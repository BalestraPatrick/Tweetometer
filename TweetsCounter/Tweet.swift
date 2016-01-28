//
//  Tweet.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/24/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import TwitterKit
import Unbox

/// We instantiate this class directly from TwitterKit so we don't need to deal with JSON in this case.

struct Tweet: Equatable, Unboxable {
    
    var tweetID: String
    var createdAt: NSDate
    var author: User? //T
    
    init(unboxer: Unboxer) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        self.createdAt = unboxer.unbox("created_at", formatter: dateFormatter)
        //        self.followersCount = unboxer.unbox("followers_count")
        self.tweetID = ""
        //        self.author = User()
    }
    
    init(tweet: TWTRTweet) {
        self.tweetID = tweet.tweetID
        self.createdAt = tweet.createdAt
        self.author = User(user: tweet.author)
    }
    
}

func == (lhs: Tweet, rhs: Tweet) -> Bool {
    return lhs.tweetID == rhs.tweetID
}

func != (lhs: Tweet, rhs: Tweet) -> Bool {
    return lhs.tweetID != rhs.tweetID
}