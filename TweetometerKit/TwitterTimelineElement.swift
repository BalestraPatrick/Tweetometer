//
//  TwitterTimelineElement.swift
//  TweetometerKit
//
//  Created by Patrick Balestra on 8/18/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import Foundation
import IGListKit

public class TwitterTimelineElement {
    public let user: User
    public let tweets: OrderedSet<Tweet>

    init(user: User, tweets: OrderedSet<Tweet>) {
        self.user = user
        self.tweets = tweets
    }
}

extension TwitterTimelineElement: ListDiffable {

    public func diffIdentifier() -> NSObjectProtocol {
        return user.hashValue ^ tweets.count as NSObjectProtocol
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? TwitterTimelineElement else { return false }
        return user == object.user && tweets == object.tweets
    }
}
