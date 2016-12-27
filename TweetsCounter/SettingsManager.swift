//
//  SettingsManager.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/21/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

protocol SettingsDelegateTweets: class {

}

protocol SettingsDelegateClient: class {
    func twitterClientDiDChange(_ value: TwitterClient)
}

struct Key {
    static let NumberOfAnalyzedTweets = "numberOfAnalyzedTweets"
    static let PreferredTwitterClient = "preferredTwitterClient"
}

enum TwitterClient {
    case web
    case twitter
    case tweetbot
    
    static func fromIndex(_ index: Int) -> TwitterClient {
        switch index {
        case 0: return .web
        case 1: return .twitter
        case 2: return .tweetbot
        default: return .web
        }
    }
    
    static func toIndex(_ option: TwitterClient) -> Int {
        switch option {
        case .web: return 0
        case .twitter: return 1
        case .tweetbot: return 2
        }
    }
}

final class SettingsManager {
    
    /// Shared manager instance
    static let sharedManager = SettingsManager()
    
    /// Delegate used to be notified when a setting changes.
    weak var delegate: SettingsDelegateTweets?
    
    weak var clientDelegate: SettingsDelegateClient?
    
    /// Number of tweets to be retrieved and analyzed. Default value is 200.
    var numberOfAnalyzedTweets: Int {
        didSet {
            Defaults[Key.NumberOfAnalyzedTweets] = numberOfAnalyzedTweets
        }
    }
    
    var preferredTwitterClient: TwitterClient {
        didSet {
            Defaults[Key.PreferredTwitterClient] = TwitterClient.toIndex(preferredTwitterClient)
            clientDelegate?.twitterClientDiDChange(preferredTwitterClient)
        }
    }
    
    init() {
        numberOfAnalyzedTweets = Defaults[Key.NumberOfAnalyzedTweets].int ?? 200
        preferredTwitterClient = TwitterClient.fromIndex(Defaults[Key.PreferredTwitterClient].int ?? 0)
        
        if let v = Defaults[Key.PreferredTwitterClient].int {
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
