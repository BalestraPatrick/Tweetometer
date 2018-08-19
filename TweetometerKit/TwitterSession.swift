//
//  Tweets.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/1/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import TwitterKit

public enum TweetometerError: Error {
    case notAuthenticated
    case invalidResponse
    case rateLimitExceeded
    case noInternetConnection
    case failedAnalysis
    case unknown(Error)

    static func from(_ error: Error) -> TweetometerError {
        switch (error as NSError).code {
        case 88: return .rateLimitExceeded
        case -1009: return .noInternetConnection
        default: return .unknown(error)
        }
    }
}

public enum Result<T> {
    case success(T)
    case error(TweetometerError)
}

public final class TwitterSession {

    public typealias CompletionBlock<T> = (Result<T>) -> Void

    /// The date of the last update with the Twitter APIs.
    public var lastUpdate = Settings.shared.lastUpdate {
        didSet {
            Settings.shared.lastUpdate = lastUpdate
        }
    }

    private lazy var client: TWTRAPIClient? = {
        if let userID = loggedInUserID {
            return TWTRAPIClient(userID: userID)
        }
        return nil
    }()

    private var loggedInUserID: String? {
        return TWTRTwitter.sharedInstance().sessionStore.session()?.userID
    }
    private var loggedInUser: TWTRUser?

    private var remainingTimelineRequests = 4
    private final let maximumTweetsPerRequest = 200

    let serialQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.waitUntilAllOperationsAreFinished()
        return queue
    }()

    var timelineCompletion: CompletionBlock<Timeline>?

    public init() { }

    /// Returns true if a user is currently logged in.
    public func isUserLoggedIn() -> Bool {
        return TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()
    }

    public func loadUserData(completion: @escaping CompletionBlock<TWTRUser>)  {
        guard let client = client, let userID = loggedInUserID else { return }
        logPerformance(.event, name: "Loading User Data", log: Subsystem.twitterSession)
        logPerformance(.end, name: "Loading User Data", log: Subsystem.twitterSession)
        client.loadUser(withID: userID) { [weak self] user, error in
            if let user = user {
                self?.loggedInUser = user
                completion(.success(user))
                logPerformance(.end, name: "Loading User Data", log: Subsystem.twitterSession, format: "success")
            } else if let error = error {
                completion(.error(TweetometerError.from(error)))
                logPerformance(.end, name: "Loading User Data", log: Subsystem.twitterSession, format: "error: %{public}@", arguments: error as CVarArg)
            }
        }
    }

    /// Log out the current user.
    public func logOutUser() {
        guard let client = client, let userId = client.userID else { return }
        TWTRTwitter.sharedInstance().sessionStore.logOutUserID(userId)
        log("Logged out user", log: Subsystem.twitterSession)
    }

    /// Get the timeline tweets of the current user.
    ///
    /// - Parameters:
    ///   - maxId: The optional maximum tweetID used to return only the oldest tweets.
    ///   - completion: The completion block containing an optional error.
    public func getTimeline(before maxId: String? = nil, completion: @escaping CompletionBlock<Timeline>) {
        guard let client = client else { return completion(.error(TweetometerError.notAuthenticated)) }
        self.timelineCompletion = completion

        let timelineOperation = TimelineDownloaderOperation(client: client)
        timelineOperation.completionBlock = {
            guard let result = timelineOperation.result else { return }
            switch result {
            case .success(let timeline): self.timelineCompletion?(.success(timeline))
            case .error(let error): self.timelineCompletion?(.error(error))
            }

        }
        serialQueue.addOperation(timelineOperation)
    }
}
