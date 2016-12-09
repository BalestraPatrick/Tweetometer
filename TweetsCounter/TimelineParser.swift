//
//  TimelineParser.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 1/28/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import Unbox
import RealmSwift

typealias JSON = Dictionary<String, AnyHashable>
typealias JSONArray = Array<JSON>

public final class TimelineParser {

    /// Final timeline object passed to our view model
    var timeline = Timeline()

    var tweets: Results<Tweet>? = nil

    init() {
        do {
            let realm = try Realm()
            tweets = realm.objects(Tweet.self)
        } catch {
            print(error)
        }
    }

    func parse(_ tweets: JSONArray) {
        let realm = try! Realm()
        // Write to Realm
        do {
            for object in tweets {
                let tweet: Tweet = try unbox(dictionary: object)
                if realm.objects(Tweet.self).contains(where: { $0.tweetId == tweet.tweetId }) == false {
                    try realm.write {
                        realm.add(tweet)
                    }
                }
            }

            // Analyze tweets and get users
            try analyze()
        } catch {
            print(error)
        }
    }

    func analyze() throws {
        guard let tweets = tweets else { return }
        let realm = try Realm()
        for tweet in tweets {
            let user = realm.object(ofType: User.self, forPrimaryKey: tweet.userId)
            if let user = user {
                print(user.tweets.count)
                try realm.write {
                    user.tweets.append(tweet)
                }
            }
        }
    }
}
