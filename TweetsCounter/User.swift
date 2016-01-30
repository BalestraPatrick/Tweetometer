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
    
    var userId: Int
    var followersCount: Int
    var followingCount: Int
    var statusesCount: Int
    var screenName: String
    var name: String
    var description: String
    var profileImageURL: NSURL?
    
    init(unboxer: Unboxer) {
        userId = unboxer.unbox("id")
        followersCount = unboxer.unbox("followers_count")
        followingCount = unboxer.unbox("friends_count")
        statusesCount = unboxer.unbox("statuses_count")
        screenName = unboxer.unbox("screen_name")
        name = unboxer.unbox("name")
        description = unboxer.unbox("description")
        profileImageURL = NSURL(string: unboxer.unbox("profile_image_url_https"))
    }
    
    init(user: TWTRUser) {
        userId = Int(user.userID) ?? 0
        followersCount = 0
        followingCount = 0
        statusesCount = 0
        screenName = user.screenName
        name = user.name
        description = ""
        profileImageURL = NSURL(string: user.profileImageLargeURL)
        
    }
}