//
//  User.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/24/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation

public class User: Codable {
    public var userId: String = ""
    public var followersCount: Int = 0
    public var followingCount: Int = 0
    public var statusesCount: Int = 0
    public var screenName: String = ""
    public var name: String = ""
    public var userDescription: String = ""
    public var profileImageURL: String?
    public var count: Int = 0
    public var location: String = ""
    public var displayURL: String?
}

public extension User {

    fileprivate func convertToBiggerFormat(_ URL: String) -> String {
        let biggerURL = URL.replacingOccurrences(of: "normal", with: "bigger")
        return biggerURL
    }

    public func tweets() -> [Tweet] {
//        let realm = try! Realm()
//        let tweets = realm.objects(Tweet.self)
//            .filter { $0.userId == self.userId }
//            .sorted { $0.0.createdAt > $0.1.createdAt }
        return []
    }

    @discardableResult
    public func tweetsCount() -> Int {
        return 0
    }

    public func retweetedTweetsCount() -> Int {
        return tweets().filter { $0.retweeted }.count
    }

    public func repliesTweetsCount() -> Int {
        return tweets().filter { $0.reply }.count
    }
}
