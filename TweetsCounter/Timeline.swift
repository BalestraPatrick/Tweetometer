//
//  Timeline.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/2/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation

class Timeline {
    
    /// Users sorted by the highest number of tweets
    var users = [User]()

    /// The Id of the oldest retrieved tweet.
    var maxID: String? = nil

    // Merge new users with already existing users (if any).
    func merge(newUsers: [User]) {

        if users.count == 0 {
            users = newUsers
        } else {
            for newUser in newUsers {
                let existingUser = users.filter { return newUser.userID == $0.userID }.first
                if var existing = existingUser {
                    users.remove(at: users.index(of: existing)!)
                    existing.tweets.append(contentsOf: newUser.tweets)
                    users.append(existing)
                }
            }
        }
//        print(users.first?.tweets.count)
    }
}

