//
//  User.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/24/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import IGListKit

public class User: Codable {
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

    required public init(from decoder: Decoder) throws {
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

extension User: ListDiffable {

    public func diffIdentifier() -> NSObjectProtocol {
        return hashValue as NSObjectProtocol
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return hashValue == (object as? User).hashValue
    }
}

extension User: Equatable {

    public static func == (lhs: User, rhs: User) -> Bool {
        return
            lhs.idStr == rhs.idStr &&
            lhs.followersCount == rhs.followersCount &&
            lhs.friendsCount == rhs.friendsCount &&
            lhs.statusesCount == rhs.statusesCount &&
            lhs.screenName == rhs.screenName &&
            lhs.name == rhs.name &&
            lhs.descriptionText == rhs.descriptionText &&
            lhs.profileBannerUrl == rhs.profileBannerUrl &&
            lhs.profileImageUrl == rhs.profileImageUrl &&
            lhs.location == rhs.location
    }
}

extension User: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(idStr)
    }
}

extension User: CustomStringConvertible {

    public var description: String {
        return "\n\t\tidStr: \(idStr),\n\t\tscreenName: \(screenName)"
    }
}

//public extension User {
//
//    fileprivate func convertToBiggerFormat(_ URL: String) -> String {
//        let biggerURL = URL.replacingOccurrences(of: "normal", with: "bigger")
//        return biggerURL
//    }
//}
