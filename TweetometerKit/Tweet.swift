//
//  Tweet.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/24/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation

public class Tweet: Codable {
    public var userId: String = ""
    public var createdAt: Date = Date()
    public var tweetId: String = ""
    public var text: String = ""
    public var language: String = ""
    public var retweetsCount: Int = 0
    public var likesCount: Int = 0
    public var retweeted: Bool = false
    public var reply: Bool = false
}
