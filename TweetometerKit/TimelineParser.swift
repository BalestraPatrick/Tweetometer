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

    /// Parse the JSON tweets into Tweet objects.
    ///
    /// - Parameter tweets: The array of JSON tweets.
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
            analyze(newTweets)
        } catch {
            print(error)
        }
    }

    /// Link all tweets with their user.
    ///
    /// - Parameter newTweets: All the newly added Tweet objects.
    func analyze(_ newTweets: [Tweet]) {
        guard newTweets.count > 0 else { return }
        let realm = DataManager.realm()
        for tweet in newTweets {
            let user = realm.object(ofType: User.self, forPrimaryKey: tweet.userId)
            if let user = user {
                user.tweetsCount()
            }
        }
    }

    /// Find the oldest tweetId and save it for the next request.
    ///
    /// - Parameter maxId: The id of the oldest tweet retrieved.
    fileprivate func findOldestTweetId(maxId: String) {
        guard let currentMaxId = self.maxId else {
            return self.maxId = maxId
        }

        if maxId < currentMaxId {
            self.maxId = maxId
        }
    }
}
