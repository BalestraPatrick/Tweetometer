//
//  User.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/24/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation

public struct User: Codable {
    public let idStr: String
    public let followersCount: Int
    public let friendsCount: Int
    public let statusesCount: Int
    public let screenName: String
    public let name: String
    public let descriptionText: String
    public let profileBannerUrl: String?
    public let profileImageUrl: String
    public let location: String

    enum CodingKeys: String, CodingKey {
        case idStr
        case followersCount
        case friendsCount
        case statusesCount
        case screenName
        case name
        case descriptionText = "description"
        case profileBannerUrl
        case profileImageUrl
        case location
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idStr = try container.decode(String.self, forKey: .idStr)
        followersCount = try container.decode(Int.self, forKey: .followersCount)
        friendsCount = try container.decode(Int.self, forKey: .friendsCount)
        statusesCount = try container.decode(Int.self, forKey: .statusesCount)
        screenName = try container.decode(String.self, forKey: .screenName)
        name = try container.decode(String.self, forKey: .name)
        descriptionText = try container.decode(String.self, forKey: .descriptionText)
        profileBannerUrl = try container.decodeIfPresent(String.self, forKey: .profileBannerUrl)
        profileImageUrl = try container.decode(String.self, forKey: .profileImageUrl)
        location = try container.decode(String.self, forKey: .location)
    }
}

extension User: CustomStringConvertible {

    public var description: String {
        return "\n\t\tidStr: \(idStr),\n\t\tscreenName: \(screenName)"
    }
}

public extension User {

    fileprivate func convertToBiggerFormat(_ URL: String) -> String {
        let biggerURL = URL.replacingOccurrences(of: "normal", with: "bigger")
        return biggerURL
    }

//    public func retweetedTweetsCount() -> Int {
//        return tweets().filter { $0.retweeted }.count
//    }
//
//    public func repliesTweetsCount() -> Int {
//        return tweets().filter { $0.reply }.count
//    }
}
