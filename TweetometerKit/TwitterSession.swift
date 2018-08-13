//
//  Tweets.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/1/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import TwitterKit

public enum TwitterError: Error {
    case notAuthenticated
    case unknown
    case invalidResponse
    case rateLimitExceeded
    case noInternetConnection
    case failedAnalysis
}

public final class TwitterSession {

    public typealias TimelineUpdate = (TwitterError?) -> Void

    /// The date of the last update with the Twitter APIs.
    public var lastUpdate = Settings.shared.lastUpdate {
        didSet {
            Settings.shared.lastUpdate = lastUpdate
        }
    }

    /// A variable that holds a Twitter client.
    private var timelineParser = TimelineParser()
    private var timelineUpdate: TimelineUpdate?
    private var timelineRequestsCount = 0
    private var queue = DispatchQueue(label: "com.patrickbalestra.tweetometer.background")

    private final let maximumTimelineRequests = 4
    private final let maximumTweetsPerRequest = 200

    /// Shared Twitter session responsible for all requests to the Twitter APIs.
    public static let shared = TwitterSession()

    /// Private initializer invoked only once in the app's lifetime.
    private init() { }

    /// Request the user's profile picture URL.
    ///
    /// - Parameter completion: The completion block that contains the profile picture URL.
    public func getProfilePictureURL(completion: @escaping (URL?) -> Void) {
//        NotificationCenter.default.post(name: NSNotification.Name.requestStarted(), object: nil)
//        guard let client = client, let userID = client.userID else { return completion(nil) }
//        client.loadUser(withID: userID) { user, _ in
//            self.user = user
//            if let stringURL = user?.profileImageLargeURL {
//                NotificationCenter.default.post(name: NSNotification.Name.requestCompleted(), object: nil)
//                return completion(URL(string: stringURL)!)
//            }
//        }
    }

    /// Log out the current user.
    public func logOutUser() {
//        guard let client = client, let userId = client.userID else { return }
        Twitter.sharedInstance().sessionStore.logOutUserID("userId")
    }

    /// Get the timeline tweets of the current user.
    ///
    /// - Parameters:
    ///   - maxId: The optional maximum tweetID used to return only the oldest tweets.
    ///   - completion: The completion block containing an optional error.
    public func getTimeline(before maxId: String?, completion: @escaping TimelineUpdate) {
//        NotificationCenter.default.post(name: NSNotification.Name.requestStarted(), object: nil)
//        timelineUpdate = completion
//        guard let client = client else { return completion(.notAuthenticated) }
//        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
//        var parameters = ["count": String(describing: maximumTweetsPerRequest), "include_entities": "false", "exclude_replies": "false"]
//        if let maxId = maxId {
//            parameters["max_id"] = maxId
//        }

//        let request = client.urlRequest(withMethod: "GET", url: url, parameters: parameters, error: nil)
//        client.sendTwitterRequest(request) { _, data, error in
//            if let error = error as? NSError {
//                NotificationCenter.default.post(name: NSNotification.Name.requestCompleted(), object: nil)
//                switch error.code {
//                case 88: return completion(.rateLimitExceeded)
//                case -1009: return completion(.noInternetConnection)
//                default: return completion(.invalidResponse)
//                }
//            }
//            guard let data = data else { return completion(.invalidResponse) }
//            do {
//                let tweets: Any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                guard let timeline = tweets as? JSONArray else { return completion(.invalidResponse) }
//                self.queue.async {
//                    self.timelineParser.parse(timeline)
//                }
//                self.timelineRequestsCount += 1
//                if let update = self.timelineUpdate {
//                    print(timeline.count)
//                    update(nil)
//                    if self.timelineRequestsCount >= self.maximumTimelineRequests {
//                        // Request completed and reset the counter
//                        NotificationCenter.default.post(name: NSNotification.Name.requestCompleted(), object: nil)
//                        self.timelineRequestsCount = 0
//                        return
//                    }
//                    self.getTimeline(before: self.timelineParser.maxId, completion: update)
//                    NotificationCenter.default.post(name: NSNotification.Name.requestCompleted(), object: nil)
//                }
//            } catch {
//                return completion(.invalidResponse)
//            }
//        }
    }
}
