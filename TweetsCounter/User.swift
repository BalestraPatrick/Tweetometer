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

class User: Object, Unboxable {

    dynamic var userId: String = ""
    dynamic var followersCount: Int = 0
    dynamic var followingCount: Int = 0
    dynamic var statusesCount: Int = 0
    dynamic var screenName: String = ""
    dynamic var name: String = ""
    dynamic var userDescription: String = ""
    dynamic var profileImageURL: String? = nil
    dynamic var tweetsCount: Int = 1
    dynamic var location: String = ""
    dynamic var displayURL: String = ""
    var tweets = List<Tweet>()

    override static func primaryKey() -> String? {
        return "userId"
    }

    override static func indexedProperties() -> [String] {
        return ["userId"]
    }

    override static func ignoredProperties() -> [String] {
        return ["tweets"]
    }

    convenience required init(unboxer: Unboxer) {
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
