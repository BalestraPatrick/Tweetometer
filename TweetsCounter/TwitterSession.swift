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

enum TwitterError: Error {
    case notAuthenticated
    case unknown
    case invalidResponse
    case failedAnalysis
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

    func getProfilePicture(completion: @escaping (URL?) -> ()) {
        guard let client = client, let userID = client.userID else { return completion(nil) }
        client.loadUser(withID: userID) { user, error in
            if let stringURL = user?.profileImageLargeURL {
                return completion(URL(string: stringURL)!)
            }
        }
    }

    func getTimeline(completion: @escaping ([User], TwitterError?) -> ()) {
        guard let client = client else { return completion([], .notAuthenticated) }
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        var parameters = ["count" : String(describing: 200), "include_entities" : "false", "exclude_replies" : "false"]
//        if let beforeID = beforeID {
//            parameters["beforeID"] = beforeID
//        }

        let request = client.urlRequest(withMethod: "GET", url: url, parameters: parameters, error: nil)
        client.sendTwitterRequest(request) { response, data, connectionError in
            guard let data = data else { return completion([], .invalidResponse) }

            do {
                let tweets: Any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                guard let tweetsArray = tweets as? Array<AnyObject> else { fatalError("Could not downcast to array") }
                let parser = TimelineParser(jsonTweets: tweetsArray)
                if let users = parser.timeline?.users {
                    return completion(users, nil)
                }
                return completion([], .failedAnalysis)
            } catch {
                return completion([], .invalidResponse)
            }
        }
    }
}
