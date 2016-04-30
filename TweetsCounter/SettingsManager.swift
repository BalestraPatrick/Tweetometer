//
//  SettingsManager.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/21/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

protocol SettingsDelegate: class {
    func numberOfAnalyzedTweetsDidChange(value: Int)
}

struct Key {
    static let NumberOfAnalyzedTweets = "numberOfAnalyzedTweets"
    static let PreferredTwitterClient = "preferredTwitterClient"
}


enum TwitterClient {
    case Web
    case Twitter
    case Tweetbot
    
    static func fromIndex(index: Int) -> TwitterClient {
        switch index {
        case 0: return .Web
        case 1: return .Twitter
        case 2: return .Tweetbot
        default: return .Web
        }
    }
    
    static func toIndex(option: TwitterClient) -> Int {
        switch option {
        case .Web: return 0
        case .Twitter: return 1
        case .Tweetbot: return 2
        }
    }
}

final class SettingsManager {
    
    /// Shared manager instance
    static let sharedManager = SettingsManager()
    
    /// Delegate used to be notified when a setting changes.
    weak var delegate: SettingsDelegate?
    
    /// Number of tweets to be retrieved and analyzed. Default value is 200.
    var numberOfAnalyzedTweets: Int {
        didSet {
            Defaults[Key.NumberOfAnalyzedTweets] = numberOfAnalyzedTweets
            delegate?.numberOfAnalyzedTweetsDidChange(numberOfAnalyzedTweets)
        }
    }
    
    var preferredTwitterClient: TwitterClient {
        didSet {
            Defaults[Key.PreferredTwitterClient] = TwitterClient.toIndex(preferredTwitterClient)
        }
    }
    
    init() {
        numberOfAnalyzedTweets = Defaults[Key.NumberOfAnalyzedTweets].int ?? 200
        
        if let v = Defaults[Key.PreferredTwitterClient].int {
            switch v {
            case 0:  preferredTwitterClient = .Tweetbot
            case 1: preferredTwitterClient = .Twitter
            default: preferredTwitterClient = .Web
            }
        } else {
            preferredTwitterClient = .Web
        }
    }
    
}
