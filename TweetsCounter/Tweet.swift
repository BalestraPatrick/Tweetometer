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

struct Tweet: Equatable, Hashable, Unboxable {
    
    var tweetID: String
    var createdAt: Date
    var text: String
    var language: String
    var screenName: String
    var retweetsCount: Int
    var likesCount: Int
    
    var author: User?
    
    var hashValue: Int {
        get {
            return tweetID.hashValue
        }
    }
    
    init(unboxer: Unboxer) {
        
        let retweeted: Bool = try! unboxer.unbox(key: "retweeted")
        if retweeted {
            // TODO
            print("Retweeted")
        }
        
        createdAt = try! unboxer.unbox(key: "created_at", formatter: DateFormatter.twitterDateFormatter())
        tweetID = try! unboxer.unbox(key: "id_str")
        text = try! unboxer.unbox(key: "text")
        language = try! unboxer.unbox(key: "lang")
        
        let userID: String = try! unboxer.unbox(key: "in_reply_to_user_id")
        author = try! unboxer.unbox(key: "user")

        if let author = author {
            screenName = author.screenName
        } else {
            screenName = ""
            print("Failed to unbox author user with JSON")
        }
        
        retweetsCount = try! unboxer.unbox(key: "retweet_count")
        likesCount = try! unboxer.unbox(key: "favorite_count")
    }
    
}

func == (lhs: Tweet, rhs: Tweet) -> Bool {
    return lhs.tweetID == rhs.tweetID
}
