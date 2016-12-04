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
    var profileImageURL: URL?
    var tweets = [Tweet]()
    var location: String
    var displayURL: String
    
    var hashValue: Int {
        get {
            return userID.hashValue
        }
    }
    
    init(unboxer: Unboxer) {
        userID = try! unboxer.unbox(key: "id_str")
        followersCount = try! unboxer.unbox(key: "followers_count")
        followingCount = try! unboxer.unbox(key: "friends_count")
        statusesCount = try! unboxer.unbox(key: "statuses_count")
        screenName = try! unboxer.unbox(key: "screen_name")
        name = try! unboxer.unbox(key: "name")
        description = try! unboxer.unbox(key: "description")
        location = try! unboxer.unbox(key: "location")
        displayURL = try! unboxer.unbox(keyPath: "entities.url.urls.0.expanded_url")
        profileImageURL = convertMediumToBiggerProfilePicture(try! unboxer.unbox(key: "profile_image_url_https"))
    }
    
    fileprivate func convertMediumToBiggerProfilePicture(_ URL: String) -> Foundation.URL {
        let biggerURLString = URL.replacingOccurrences(of: "normal", with: "bigger")
        let biggerURL = Foundation.URL(string: biggerURLString)!
        return biggerURL
    }
}

func == (lhs: User, rhs: User) -> Bool {
    return lhs.userID == rhs.userID
}
