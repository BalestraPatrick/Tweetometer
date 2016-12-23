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
    dynamic var retweetsCount: Int = 0
    dynamic var likesCount: Int = 0
    dynamic var retweeted: Bool = false

    override static func primaryKey() -> String? {
        return "tweetId"
    }

    override static func indexedProperties() -> [String] {
        return ["tweetId", "userId"]
    }

    convenience required init(unboxer: Unboxer) {
        self.init()
        do {
            userId = try unboxer.unbox(keyPath: "user.id")
            tweetId = try unboxer.unbox(key: "id_str")
            createdAt = try unboxer.unbox(key: "created_at", formatter: DateFormatter.twitterDateFormatter())
            text = try unboxer.unbox(key: "text")
            language = try unboxer.unbox(key: "lang")
            retweeted = try unboxer.unbox(key: "retweeted")
            retweetsCount = try unboxer.unbox(key: "retweet_count")
            likesCount = try unboxer.unbox(key: "favorite_count")
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
            } catch {
                print(error)
            }
        }
    }
}
