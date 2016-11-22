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
    
    let tweetID: String
    let createdAt: Date
    let text: String
    let language: String
    let screenName: String
    let retweetsCount: Int
    let likesCount: Int
    let retweeted: Bool
    let author: User?
    
    init(unboxer: Unboxer) {
//        let id: Int = try! unboxer.unbox(keyPath: "user.id")
        tweetID = try! unboxer.unbox(key: "id_str")
        createdAt = try! unboxer.unbox(key: "created_at", formatter: DateFormatter.twitterDateFormatter())
        text = try! unboxer.unbox(key: "text")
        language = try! unboxer.unbox(key: "lang")
        retweeted = try! unboxer.unbox(key: "retweeted")
        author = unboxer.unbox(key: "user")
        screenName = author?.screenName ?? ""
        retweetsCount = try! unboxer.unbox(key: "retweet_count")
        likesCount = try! unboxer.unbox(key: "favorite_count")
    }

    // MARK: Equatable
    static func == (lhs: Tweet, rhs: Tweet) -> Bool {
        return lhs.tweetID == rhs.tweetID
    }

    // MARK: Hashable
    var hashValue: Int {
        get {
            return tweetID.hashValue
        }
    }
}
