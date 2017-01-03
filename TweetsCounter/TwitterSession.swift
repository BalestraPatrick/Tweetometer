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

    /// A computed property needed to initialize the client used to perform all Twitter requests.
    private var client: TWTRAPIClient? {
        get {
            if _client == nil {
                if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
                    return TWTRAPIClient(userID: userID)
                }
            }
            return _client
        }
        set {
            _client = client
        }
    }

    /// A variable that holds a Twitter client.
    private var _client: TWTRAPIClient?
    private var user: TWTRUser?
    private var timelineParser = TimelineParser()
    private var timelineUpdate: TimelineUpdate?
    private var timelineRequestsCount = 0

    private final let maximumTimelineRequests = 4
    private final let maximumTweetsPerRequest = 200

    /// Shared Twitter session responsible for all requests to the Twitter APIs.
    public static let shared: TwitterSession = {
        return TwitterSession()
    }()

    /// Private initializer invoked only once in the app's lifetime.
    private init() {
    }

    ///  Check the session user ID to see if there is an user logged in.
    public func isUserLoggedIn() -> Bool {
        return client != nil
    }

    /// Returns the current user screenName to be displayed on the UI.
    ///
    /// - Returns: The current user screenName.
    public func loggedUserScreenName() -> String {
        return user?.screenName ?? ""
    }

    /// Request the user's profile picture URL.
    ///
    /// - Parameter completion: The completion block that contains the profile picture URL.
    public func getProfilePictureURL(completion: @escaping (URL?) -> ()) {
        NotificationCenter.default.post(name: requestStartedNotification(), object: nil)
        guard let client = client, let userID = client.userID else { return completion(nil) }
        client.loadUser(withID: userID) { user, error in
            self.user = user
            if let stringURL = user?.profileImageLargeURL {
                NotificationCenter.default.post(name: requestCompletedNotification(), object: nil)
                return completion(URL(string: stringURL)!)
            }
        }
    }

    /// Log out the current user.
    public func logOutUser() {
        guard let client = client, let userId = client.userID else { return }
        Twitter.sharedInstance().sessionStore.logOutUserID(userId)
    }

    /// Get the timeline tweets of the current user.
    ///
    /// - Parameters:
    ///   - maxId: The optional maximum tweetID used to return only the oldest tweets.
    ///   - completion: The completion block containing an optional error.
    public func getTimeline(before maxId: String?, completion: @escaping TimelineUpdate) {
        NotificationCenter.default.post(name: requestStartedNotification(), object: nil)
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
                NotificationCenter.default.post(name: requestCompletedNotification(), object: nil)
                switch error.code {
                case 88: return completion(.rateLimitExceeded)
                case -1009: return completion(.noInternetConnection)
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
                        NotificationCenter.default.post(name: requestCompletedNotification(), object: nil)
                        return
                    }
                    self.getTimeline(before: self.timelineParser.maxId, completion: update)
                    NotificationCenter.default.post(name: requestCompletedNotification(), object: nil)
                }
            } catch {
                return completion(.invalidResponse)
            }
        }
    }
}
