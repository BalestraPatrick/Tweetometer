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

    /// The Id of the oldest retrieved tweet.
    var maxId: String? = nil

    var tweets: Results<Tweet>? = nil

    init() {
        let realm = DataManager.realm()
        tweets = realm.objects(Tweet.self)
    }

    func parse(_ tweets: JSONArray) {
        let realm = DataManager.realm()
        var newTweets = [Tweet]()
        // Write to Realm
        do {
            for object in tweets {
                let tweet: Tweet = try unbox(dictionary: object)
                if realm.objects(Tweet.self).contains(where: { $0.tweetId == tweet.tweetId }) == false {
                    findOldestTweetId(maxId: tweet.tweetId)
                    newTweets.append(tweet)
                    try realm.write {
                        realm.add(tweet)
                    }
                }
            }

            // Analyze tweets and find users
            try analyze(newTweets)
        } catch {
            print(error)
        }
    }

    func analyze(_ newTweets: [Tweet]) throws {
        guard newTweets.count > 0 else { return }
        let realm = DataManager.realm()
        for tweet in newTweets {
            let user = realm.object(ofType: User.self, forPrimaryKey: tweet.userId)
            if let user = user {
                print("New tweets: \(newTweets.count)")
                try realm.write {
                    user.tweets.append(tweet)
                }
            }
        }
    }

    fileprivate func findOldestTweetId(maxId: String) {
        guard let currentMaxId = self.maxId else {
            return self.maxId = maxId
        }

        if maxId < currentMaxId {
            self.maxId = maxId
        }
    }
}
