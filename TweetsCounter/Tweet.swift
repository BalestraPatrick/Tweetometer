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

public class Tweet: Object, Unboxable {

    dynamic public var userId: String = ""
    dynamic public var createdAt: Date = Date()
    dynamic public var tweetId: String = ""
    dynamic public var text: String = ""
    dynamic public var language: String = ""
    dynamic public var retweetsCount: Int = 0
    dynamic public var likesCount: Int = 0
    dynamic public var retweeted: Bool = false

    override public static func primaryKey() -> String? {
        return "tweetId"
    }

    override public static func indexedProperties() -> [String] {
        return ["tweetId", "userId"]
    }

    convenience required public init(unboxer: Unboxer) {
        self.init()
        do {
            userId = try unboxer.unbox(keyPath: "user.id")
            tweetId = try unboxer.unbox(key: "id_str")
            createdAt = try unboxer.unbox(key: "created_at", formatter: DateFormatter.twitterDateFormatter())
            text = try unboxer.unbox(key: "text")
            language = try unboxer.unbox(key: "lang")
            do {
                likesCount = try unboxer.unbox(keyPath: "retweeted_status.favorite_count")
                retweetsCount = try unboxer.unbox(key: "retweet_count")
                retweeted = true
            } catch {
                likesCount = try unboxer.unbox(key: "favorite_count")
                retweetsCount = try unboxer.unbox(key: "retweet_count")
                retweeted = false
            }
            createUser(unboxer: unboxer)
        } catch {
            print(error)
        }
    }

    /// Create a user if its not in the Realm.
    ///
    /// - Parameter unboxer: The object used to decode the JSON.
    private func createUser(unboxer: Unboxer) {
        let realm = DataManager.realm()
        let user = realm.object(ofType: User.self, forPrimaryKey: userId)
        // If no user is found with the userID, create it.
        if user == nil {
            do {
                let newUser: User = try unboxer.unbox(key: "user")
                try! realm.write {
                    realm.add(newUser)
                }
                // Check if we have to clean some Tweets from the cache.
                DataManager.shouldCleanCache()
            } catch {
                print(error)
            }
        }
    }
}
