//
//  User.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/24/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import Unbox
import TwitterKit

struct User: Equatable, Hashable, Unboxable {
    
    var userID: String
    var followersCount: Int
    var followingCount: Int
    var statusesCount: Int
    var screenName: String
    var name: String
    var description: String
    var profileImageURL: NSURL?
    var tweets: [Tweet]?
    
    var hashValue: Int {
        get {
            return userID.hashValue
        }
    }
    
    init(unboxer: Unboxer) {
        userID = unboxer.unbox("id_str")
        followersCount = unboxer.unbox("followers_count")
        followingCount = unboxer.unbox("friends_count")
        statusesCount = unboxer.unbox("statuses_count")
        screenName = unboxer.unbox("screen_name")
        name = unboxer.unbox("name")
        description = unboxer.unbox("description")
        profileImageURL = convertMediumToBiggerProfilePicture(unboxer.unbox("profile_image_url_https"))
    }
    
    private func convertMediumToBiggerProfilePicture(URL: String) -> NSURL {
        let biggerURLString = URL.stringByReplacingOccurrencesOfString("normal", withString: "bigger")
        let biggerURL = NSURL(string: biggerURLString)!
        return biggerURL
    }
}

func == (lhs: User, rhs: User) -> Bool {
    return lhs.userID == rhs.userID
}