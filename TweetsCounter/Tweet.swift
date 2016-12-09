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
        do {
            userId = try unboxer.unbox(keyPath: "user.id")
            tweetId = try unboxer.unbox(key: "id_str")
            createdAt = try unboxer.unbox(key: "created_at", formatter: DateFormatter.twitterDateFormatter())
            text = try unboxer.unbox(key: "text")
            language = try unboxer.unbox(key: "lang")
            retweed = try unboxer.unbox(key: "retweeted")
            retweetsCount = try unboxer.unbox(key: "retweet_count")
            likesCount = try unboxer.unbox(key: "favorite_count")
            retweed = try unboxer.unbox(key: "retweeted")
            try createUser(unboxer: unboxer)
        } catch {
            print(error)
        }
    }

    private func createUser(unboxer: Unboxer) throws {
        let realm = try Realm()
        let user = realm.object(ofType: User.self, forPrimaryKey: userId)
        if user == nil {
            let newUser: User = try unboxer.unbox(key: "user")
            try realm.write {
                realm.add(newUser)
            }
        }
    }
}
