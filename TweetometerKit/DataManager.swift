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
                    schemaVersion: 2,
                    migrationBlock: { migration, oldSchemaVersion in
                        if oldSchemaVersion == 1 {
                            // Migrate first version of the database to the second.
                            // Here we just manually set the newly added `reply` property based on the text of the Tweet.
                            migration.enumerateObjects(ofType: Tweet.className()) { oldObject, newObject in
                                guard let new = newObject, let old = oldObject else { return }
                                new["reply"] = (old["text"] as! String).hasPrefix("@")
                            }
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
        let maximumCount = Settings.shared.maximumNumberOfTweets
        while realm.objects(Tweet.self).count > maximumCount {
            let tweets = realm.objects(Tweet.self)
            if let oldestTweet = tweets.min(by: { $0.tweetId < $1.tweetId }) {
                // Delete from user tweets array and delete user if it doesn't have any more tweets.
                if let user = realm.object(ofType: User.self, forPrimaryKey: oldestTweet.userId) {
                    if let index = user.tweets.index(of: oldestTweet) {
                        try! realm.write {
                            user.tweets.remove(objectAtIndex: index)
                            user.tweetsCount = user.tweets.count
                            if user.tweetsCount == 0 {
                                realm.delete(user)
                            }
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
