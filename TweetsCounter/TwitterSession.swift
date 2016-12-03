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
    private var timelineParser = TimelineParser()

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

//    func startStreamingTweets(completion: @escaping ([User], TwitterError?) -> Void) {
//        var maxID: String? = nil
//        let queue = OperationQueue()
//
//
//        let request = BlockOperation {
//            print("Requesting tweets: \(maxID)")
//            self.getTimeline(before: maxID) { tweets, error in
//                guard error == nil else { return completion([], error) }
//                self.timelineParser = TimelineParser(jsonTweets: tweets)
//                if let timeline = self.timelineParser?.timeline {
//                    // Do something with users
//                    maxID = timeline.maxID
//                    print("Received new tweets: \(maxID)")
//                    queue.addOperation(request)
//                }
//            }
//        }
//        queue.addOperation(request)
//
//    }

    func getTimeline(before maxID: String?, completion: @escaping (Timeline?, TwitterError?) -> Void) {
        guard let client = client else { return completion(nil, .notAuthenticated) }
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        var parameters = ["count" : String(describing: 200), "include_entities" : "false", "exclude_replies" : "false"]
        if let maxID = maxID {
            parameters["max_id"] = maxID
        }

        let request = client.urlRequest(withMethod: "GET", url: url, parameters: parameters, error: nil)
        client.sendTwitterRequest(request) { response, data, connectionError in
            guard let data = data else { return completion(nil, .invalidResponse) }
            do {
                let tweets: Any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                guard let timeline = tweets as? Array<AnyObject> else { return completion(nil, .invalidResponse) }
                self.timelineParser.analyze(timeline)
                return completion(self.timelineParser.timeline, nil)
            } catch {
                return completion(nil, .invalidResponse)
            }
        }
    }
}
