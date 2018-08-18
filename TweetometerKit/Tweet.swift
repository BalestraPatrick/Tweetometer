//
//  Tweet.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/24/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation

public struct Tweet: Codable {
    public let idStr: String
    public let createdAt: Date
    public let favoriteCount: Int
    public let retweetCount: Int
    public let retweeted: Bool
    public let user: User
    public let text: String
}

extension Tweet: CustomStringConvertible {

    public var description: String {
        return "\nTweet:\n\tidStr: \(idStr)\n\ttext: \(text)\n\tuser: \(user.description)"
    }
}
