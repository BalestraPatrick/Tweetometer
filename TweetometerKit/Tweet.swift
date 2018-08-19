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
        return idStr as NSString
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let idStr2 = object?.diffIdentifier() as? String else { return false }
        return idStr == idStr2
    }
}

extension Tweet: CustomStringConvertible {

    public var description: String {
        return "\nTweet:\n\tidStr: \(idStr)\n\ttext: \(text)\n\tuser: \(user.description)"
    }
}
