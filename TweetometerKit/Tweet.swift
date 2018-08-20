//
//  Tweet.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/24/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import IGListKit

public class Tweet: Codable {
    public let idStr: String
    public let createdAt: Date
    public let favoriteCount: Int
    public let retweetCount: Int
    public let retweeted: Bool
    public let user: User
    public let text: String
}

extension Tweet: ListDiffable {

    public func diffIdentifier() -> NSObjectProtocol {
        return hashValue as NSObjectProtocol
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return hashValue == (object as? Tweet).hashValue
    }
}

extension Tweet: Equatable {

    public static func == (lhs: Tweet, rhs: Tweet) -> Bool {
        return
            lhs.idStr == rhs.idStr &&
            lhs.createdAt == rhs.createdAt &&
            lhs.favoriteCount == rhs.favoriteCount &&
            lhs.retweetCount == rhs.retweetCount &&
            lhs.retweeted == rhs.retweeted &&
            lhs.user == rhs.user &&
            lhs.text == rhs.text
    }
}

extension Tweet: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(idStr)
    }
}

extension Tweet: CustomStringConvertible {

    public var description: String {
        return "\nTweet:\n\tidStr: \(idStr)\n\ttext: \(text)\n\tuser: \(user.description)"
    }
}
