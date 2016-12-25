//
//  User.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/24/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import Unbox
import RealmSwift

public class User: Object, Unboxable {

    dynamic public var userId: String = ""
    dynamic public var followersCount: Int = 0
    dynamic public var followingCount: Int = 0
    dynamic public var statusesCount: Int = 0
    dynamic public var screenName: String = ""
    dynamic public var name: String = ""
    dynamic public var userDescription: String = ""
    dynamic public var profileImageURL: String? = nil
    dynamic public var tweetsCount: Int = 1
    dynamic public var location: String = ""
    dynamic public var displayURL: String = ""
    public var tweets = List<Tweet>()

    override public static func primaryKey() -> String? {
        return "userId"
    }

    override public static func indexedProperties() -> [String] {
        return ["userId"]
    }

    override public static func ignoredProperties() -> [String] {
        return ["tweets"]
    }

    convenience required public init(unboxer: Unboxer) {
        self.init()
        do {
            userId = try unboxer.unbox(key: "id_str")
            followersCount = try unboxer.unbox(key: "followers_count")
            followingCount = try unboxer.unbox(key: "friends_count")
            statusesCount = try unboxer.unbox(key: "statuses_count")
            screenName = try unboxer.unbox(key: "screen_name")
            name = try unboxer.unbox(key: "name")
            userDescription = try unboxer.unbox(key: "description")
            location = try unboxer.unbox(key: "location")
            displayURL = try unboxer.unbox(keyPath: "entities.url.urls.0.expanded_url")
            // TODO: investigate image bug here
            profileImageURL = convertToBiggerFormat(try! unboxer.unbox(key: "profile_image_url_https"))
        } catch {
            print(error)
        }
    }

    private func convertToBiggerFormat(_ URL: String) -> String {
        let biggerURL = URL.replacingOccurrences(of: "normal", with: "bigger")
        return biggerURL
    }
}
