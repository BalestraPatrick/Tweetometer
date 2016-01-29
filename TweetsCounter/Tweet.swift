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
    var author: User? // TODO: shouldn't be optional
    var text: String
    
    init(unboxer: Unboxer) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        self.createdAt = unboxer.unbox("created_at", formatter: dateFormatter)
        //        self.followersCount = unboxer.unbox("followers_count")
        self.tweetID = unboxer.unbox("id")
        self.text = unboxer.unbox("text")
        let user: Dictionary<String, AnyObject> = unboxer.unbox("user")
//        let tweetOwner = User(unboxer: user)
        //        self.author = User()
    }
    
    init(tweet: TWTRTweet) {
        self.tweetID = tweet.tweetID
        self.createdAt = tweet.createdAt
        self.author = User(user: tweet.author)
        self.text = tweet.text
    }
    
}

func == (lhs: Tweet, rhs: Tweet) -> Bool {
    return lhs.tweetID == rhs.tweetID
}

func != (lhs: Tweet, rhs: Tweet) -> Bool {
    return lhs.tweetID != rhs.tweetID
}