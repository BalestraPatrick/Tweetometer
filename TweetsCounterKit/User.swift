//
//  User.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/31/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

//import Foundation

struct User {
    var username: String
    var image: NSURL
    var followers: Int
    var following: Int
    var tweetsCount: Int
    
    init(username: String, image: NSURL, followers: Int, following: Int, tweetsCount: Int) {
        self.username = username
        self.image = image
        self.followers = followers
        self.following = following
        self.tweetsCount = tweetsCount
    }
}