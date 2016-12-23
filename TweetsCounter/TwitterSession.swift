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
    case rateLimitExceeded
    case failedAnalysis
}

final class TwitterSession {

    typealias TimelineUpdate = (TwitterError?) -> Void

    private var client: TWTRAPIClient?
    private var timelineParser = TimelineParser()
    private var timelineUpdate: TimelineUpdate?
    private var timelineRequestsCount = 0
    private final let maximumTimelineRequests = 4
    private final let maximumTweetsPerRequest = 200

    init() {
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            client = TWTRAPIClient(userID: userID)
        }
    }
    
    ///  Check the session user ID to see if there is an user logged in.
    func isUserLoggedIn() -> Bool {
        return client != nil
    }

    /// Request the user's profile picture URL.
    ///
    /// - Parameter completion: The completion block that contains the profile picture URL.
    func getProfilePictureURL(completion: @escaping (URL?) -> ()) {
        guard let client = client, let userID = client.userID else { return completion(nil) }
        client.loadUser(withID: userID) { user, error in
            if let stringURL = user?.profileImageLargeURL {
                return completion(URL(string: stringURL)!)
            }
        }
    }

    /// Log out the current user.
    func logOutUser() {
        guard let client = client, let userId = client.userID else { return }
        Twitter.sharedInstance().sessionStore.logOutUserID(userId)
    }

    /// Get the timeline tweets of the current user.
    ///
    /// - Parameters:
    ///   - maxId: The optional maximum tweetID used to return only the oldest tweets.
    ///   - completion: The completion block containing an optional error.
    func getTimeline(before maxId: String?, completion: @escaping TimelineUpdate) {
        timelineUpdate = completion
        guard let client = client else { return completion(.notAuthenticated) }
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        var parameters = ["count" : String(describing: maximumTweetsPerRequest), "include_entities" : "false", "exclude_replies" : "false"]
        if let maxId = maxId {
            parameters["max_id"] = maxId
        }

        let request = client.urlRequest(withMethod: "GET", url: url, parameters: parameters, error: nil)
        client.sendTwitterRequest(request) { response, data, error in
            if let error = error as? NSError {
                switch error.code {
                case 88: return completion(.rateLimitExceeded)
                default: return completion(.invalidResponse)
                }
            }
            guard let data = data else { return completion(.invalidResponse) }
            do {
                let tweets: Any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                guard let timeline = tweets as? JSONArray else { return completion(.invalidResponse) }

                self.timelineParser.parse(timeline)

                self.timelineRequestsCount += 1
                if let update = self.timelineUpdate {
                    update(nil)
                    if self.timelineRequestsCount >= self.maximumTimelineRequests {
                        return
                    }
                    self.getTimeline(before: self.timelineParser.maxId, completion: update)
                }
            } catch {
                return completion(.invalidResponse)
            }
        }
    }
}
