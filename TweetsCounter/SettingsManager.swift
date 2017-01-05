//
//  SettingsManager.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/21/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import Crashlytics

struct Key {
    static let maximumNumberOfTweets = "maximumNumberOfTweets"
    static let preferredTwitterClient = "preferredTwitterClient"
    static let lastUpdate = "lastUpdate"
}

public enum TwitterClient: CustomStringConvertible {
    case web
    case twitter
    case tweetbot
    
    public static func fromIndex(_ index: Int) -> TwitterClient {
        switch index {
        case 0: return .web
        case 1: return .twitter
        case 2: return .tweetbot
        default: return .web
        }
    }
    
    public static func toIndex(_ option: TwitterClient) -> Int {
        switch option {
        case .web: return 0
        case .twitter: return 1
        case .tweetbot: return 2
        }
    }

    public var description: String {
        switch self {
        case .web: return "Safari"
        case .twitter: return "Twitter"
        case .tweetbot: return "Tweetbot"
        }
    }
}

public final class Settings {
    
    /// Shared manager instance
    public static let shared = Settings()

    /// Number of tweets to be retrieved and analyzed. Default value is 200.
    public var maximumNumberOfTweets: Int {
        didSet {
            Defaults[Key.maximumNumberOfTweets] = maximumNumberOfTweets
        }
    }

    /// The preferred client that the user would like to use.
    public var preferredTwitterClient: TwitterClient {
        didSet {
            Defaults[Key.preferredTwitterClient] = TwitterClient.toIndex(preferredTwitterClient)
        }
    }

    /// The date of the last update with the Twitter APIs.
    public var lastUpdate: Date {
        didSet {
            Defaults[Key.lastUpdate] = lastUpdate
        }
    }
    
    private init() {
        maximumNumberOfTweets = Defaults[Key.maximumNumberOfTweets].int ?? 1000
        lastUpdate = Defaults[Key.lastUpdate].date ?? Date(timeIntervalSince1970: 0)
        preferredTwitterClient = TwitterClient.fromIndex(Defaults[Key.preferredTwitterClient].int ?? 0)
        logEvents()

        // Convert initial values to TwitterClient enum case
        if let v = Defaults[Key.preferredTwitterClient].int {
            switch v {
            case 0:  preferredTwitterClient = .web
            case 1: preferredTwitterClient = .twitter
            case 2: preferredTwitterClient = .tweetbot
            default: preferredTwitterClient = .web
            }
        } else {
            preferredTwitterClient = .web
        }
    }

    private func logEvents() {
        Answers.logCustomEvent(withName: "Maximum Number of Tweets", customAttributes: ["value" : maximumNumberOfTweets])
        Answers.logCustomEvent(withName: "Twitter Client", customAttributes: ["value" : preferredTwitterClient.description])
    }
}
