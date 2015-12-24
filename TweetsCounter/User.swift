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

struct User: Unboxable {
    
    var userID: String
    var followersCount: Int
    var followingCount: Int
    var statusesCount: Int
    var screenName: String
    var name: String
    var profileImageURL: NSURL?
    
    init(unboxer: Unboxer) {
        self.userID = unboxer.unbox("id")
        self.followersCount = unboxer.unbox("followers_count")
        self.followingCount = unboxer.unbox("friends_count")
        self.statusesCount = unboxer.unbox("statuses_count")
        self.screenName = unboxer.unbox("screen_name")
        self.name = unboxer.unbox("name")
        self.profileImageURL = NSURL(string: unboxer.unbox("profile_image_url_https"))
    }
    
    init(user: TWTRUser) {
        self.userID = user.userID
        self.followersCount = 0
        self.followingCount = 0
        self.statusesCount = 0
        self.screenName = user.screenName
        self.name = user.name
        self.profileImageURL = NSURL(string: user.profileImageLargeURL)
    }
}