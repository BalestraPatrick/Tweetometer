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

struct Tweet: Equatable, Unboxable {
    
    var tweetID: String
    var createdAt: NSDate
    var author: User?
    var text: String
    var language: String
    
    init(unboxer: Unboxer) {
        
        let retweeted: Bool = unboxer.unbox("retweeted")
        if retweeted {
            // TODO: handle retweet case
        }
        
        // TODO: Abstract date formatting
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
        createdAt = unboxer.unbox("created_at", formatter: dateFormatter)
        
        tweetID = unboxer.unbox("id")
        text = unboxer.unbox("text")
        language = unboxer.unbox("lang")
        
        let userJSON: Dictionary<String, AnyObject> = unboxer.unbox("user")
        author = Unbox(userJSON)

        if author == nil {
            print("Failed to unbox author user with JSON: \(userJSON)")
        }
    }
    
    init(tweet: TWTRTweet) {
        tweetID = tweet.tweetID
        createdAt = tweet.createdAt
        author = User(user: tweet.author)
        text = tweet.text
        language = tweet.languageCode
    }
    
}

func == (lhs: Tweet, rhs: Tweet) -> Bool {
    return lhs.tweetID == rhs.tweetID
}

func != (lhs: Tweet, rhs: Tweet) -> Bool {
    return lhs.tweetID != rhs.tweetID
}