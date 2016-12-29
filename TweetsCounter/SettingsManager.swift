//
//  SettingsManager.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/21/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

struct Key {
    static let maximumNumberOfTweets = "maximumNumberOfTweets"
    static let preferredTwitterClient = "preferredTwitterClient"
}

public enum TwitterClient {
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
}

public final class SettingsManager {
    
    /// Shared manager instance
    public static let shared = SettingsManager()

    /// Number of tweets to be retrieved and analyzed. Default value is 200.
    public var maximumNumberOfTweets: Int {
        didSet {
            Defaults[Key.maximumNumberOfTweets] = maximumNumberOfTweets
        }
    }
    
    public var preferredTwitterClient: TwitterClient {
        didSet {
            Defaults[Key.preferredTwitterClient] = TwitterClient.toIndex(preferredTwitterClient)
        }
    }
    
    private init() {
        maximumNumberOfTweets = Defaults[Key.maximumNumberOfTweets].int ?? 1000
        preferredTwitterClient = TwitterClient.fromIndex(Defaults[Key.preferredTwitterClient].int ?? 0)
        
        if let v = Defaults[Key.preferredTwitterClient].int {
            switch v {
            case 0:  preferredTwitterClient = .tweetbot
            case 1: preferredTwitterClient = .twitter
            default: preferredTwitterClient = .web
            }
        } else {
            preferredTwitterClient = .web
        }
    }
}
