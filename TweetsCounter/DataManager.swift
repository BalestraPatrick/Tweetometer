//
//  RealmManager.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/12/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import Foundation
import RealmSwift

public final class DataManager {

    /// Creates and in-memory Realm in case we are running in a unit testing target, otherwise uses a normal on-disk Realm.
    ///
    /// - Returns: An in-memory on an on-disk Realm depending on the environment. 
    public class func realm() -> Realm {
        do {
            if let _ = NSClassFromString("XCTest") {
                Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "TimelineParser"
                return try! Realm()
            } else {
                let config = Realm.Configuration(
                    schemaVersion: 1,
                    migrationBlock: { migration, oldSchemaVersion in
                        if oldSchemaVersion < 1 {
                            // Update custom properties here
                        }
                })
                Realm.Configuration.defaultConfiguration = config
                return try Realm()
            }
        } catch {
            fatalError("Could not initialize a Realm instance: \(error)")
        }
    }

    /// Logs out the current user and cleans the Realm database.
    public class func logOut() {
        TwitterSession.shared.logOutUser()
        try! self.realm().write {
            realm().deleteAll()
        }
    }

    /// Remove the oldest tweets based on the user preference.
    public class func shouldCleanCache() {
        let realm = self.realm()
        let maximumCount = SettingsManager.shared.maximumNumberOfTweets
        while realm.objects(Tweet.self).count > maximumCount {
            print("count: \(realm.objects(Tweet.self).count) >= maximumCount: \(maximumCount)")
            let tweets = realm.objects(Tweet.self)
            if let oldestTweet = tweets.min(by: { $0.tweetId < $1.tweetId }) {
                // Delete from user tweets array and delete user if it doesn't have any more tweets.
                if let user = realm.object(ofType: User.self, forPrimaryKey: oldestTweet.userId) {
                    try! realm.write {
                        user.tweets.remove(objectAtIndex: user.tweets.index(of: oldestTweet)!)
                        user.tweetsCount = user.tweets.count
                        if user.tweetsCount == 0 {
                            realm.delete(user)
                        }
                    }
                }

                // Delete the oldest tweet.
                try! realm.write {
                    realm.delete(oldestTweet)
                }
            }
        }
    }
}
