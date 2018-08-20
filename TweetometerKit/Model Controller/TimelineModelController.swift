//
//  TimelineModelController.swift
//  TweetometerKit
//
//  Created by Patrick Balestra on 8/19/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import Foundation

public class TimelineModelController {

    private var tweets = [Tweet]()
    private var _usersTimeline = [TwitterTimelineElement]()

    public func usersTimeline() -> [TwitterTimelineElement] {
        return _usersTimeline
    }

    func add(tweets: [Tweet]) {
        print("New tweets: \(tweets.count)")
        self.tweets.append(contentsOf: tweets)
        print("New total tweets: \(self.tweets.count)")
        computeTimeline()
    }

    func computeTimeline() {
        _usersTimeline = tweets
            .reduce(into: _usersTimeline) { result, tweet in
                if let index = result.firstIndex(where: { $0.user == tweet.user }) {
                    let element = result[index]
                    var newTweets = element.tweets
                    newTweets.append(tweet)
                    result[index] = TwitterTimelineElement(user: element.user, tweets: newTweets)
                } else {
                    result.append(TwitterTimelineElement(user: tweet.user, tweets: [tweet]))
                }
            }
            .sorted { $0.tweets.count > $1.tweets.count }
        print(_usersTimeline)
    }
}
