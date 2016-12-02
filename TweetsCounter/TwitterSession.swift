//
//  Tweets.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/1/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import TwitterKit
import AlamofireImage

enum TwitterRequestError: Error {
    case notAuthenticated
    case unknown
}

final class TwitterSession {
    
    private var client: TWTRAPIClient?


    init() {
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            client = TWTRAPIClient(userID: userID)
        }
    }
    
    ///  Check the session user ID to see if there is an user logged in.
    func isUserLoggedIn() -> Bool {
        return client != nil
    }

    func getProfilePicture(completion: @escaping (URL) -> ()) {
        if let client = client, let userID = client.userID {
            client.loadUser(withID: userID) { user, error in
                if let stringURL = user?.profileImageLargeURL {
                    return completion(URL(string: stringURL)!)
                }
            }
        }
    }
}
