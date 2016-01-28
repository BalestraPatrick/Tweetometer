//
//  TimelineParser.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 1/28/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import Unbox

public class TimelineParser {
    
    var tweets:[[AnyObject]]
    
    init(tweets: [[AnyObject]]) {
        self.tweets = tweets
        parseTweets()
    }
    
    private func parseTweets() -> [[User]] {
        var users = [[User]]()
        for userTweets in self.tweets {
            for tweet in userTweets {
                if let tweet = tweet as? Dictionary<String, AnyObject> {
                    do {
                        let user: User = try UnboxOrThrow(tweet)
                    } catch {
                        print(tweet)
                        print(error)
                    }
                }

            }
            print(userTweets)
        }
        return users
    }
}
