//
//  Tweet.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/24/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import Unbox
import RealmSwift

class Tweet: Object, Unboxable {

    dynamic var userId: String = ""
    dynamic var createdAt: Date = Date()
    dynamic var tweetId: String = ""
    dynamic var text: String = ""
    dynamic var language: String = ""
    dynamic var screenName: String = ""
    dynamic var retweetsCount: Int = 0
    dynamic var likesCount: Int = 0
    dynamic var retweed: Bool = false

    override static func primaryKey() -> String? {
        return "tweetId"
    }

    override static func indexedProperties() -> [String] {
        return ["tweetId", "userId"]
    }

    convenience required init(unboxer: Unboxer) {
        self.init()
        tweetId = try! unboxer.unbox(key: "id_str")
        createdAt = try! unboxer.unbox(key: "created_at", formatter: DateFormatter.twitterDateFormatter())
        text = try! unboxer.unbox(key: "text")
        language = try! unboxer.unbox(key: "lang")
        retweed = try! unboxer.unbox(key: "retweeted")
        retweetsCount = try! unboxer.unbox(key: "retweet_count")
        likesCount = try! unboxer.unbox(key: "favorite_count")
        //        let id: Int = try! unboxer.unbox(keyPath: "user.id")
        //            author = unboxer.unbox(key: "user")
        //            screenName = author?.screenName ?? ""
    }

}

//struct Tweet: Equatable, Hashable, Unboxable {
//    
//    let tweetID: String
//    let createdAt: Date
//    let text: String
//    let language: String
//    let screenName: String
//    let retweetsCount: Int
//    let likesCount: Int
//    let retweeted: Bool
//    let author: User?
//    
//
//    // MARK: Equatable
//
//    static func == (lhs: Tweet, rhs: Tweet) -> Bool {
//        return lhs.tweetID == rhs.tweetID
//    }
//
//    // MARK: Hashable
//
//    var hashValue: Int {
//        get {
//            return tweetID.hashValue
//        }
//    }
//}
