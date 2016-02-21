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
}


final class SettingsManager {
    
    /// Shared manager instance
    static let sharedManager = SettingsManager()
    
    /// Delegate used to be notified when a setting changes.
    weak var delegate: SettingsDelegate?
    
    /// Number of tweets to be retrieved and analyzed. Default value is 200.
    var numberOfAnalyzedTweets: Int = Defaults[Key.NumberOfAnalyzedTweets].int ?? 200 {
        didSet {
            Defaults[Key.NumberOfAnalyzedTweets] = numberOfAnalyzedTweets
            delegate?.numberOfAnalyzedTweetsDidChange(numberOfAnalyzedTweets)
        }
    }
}
