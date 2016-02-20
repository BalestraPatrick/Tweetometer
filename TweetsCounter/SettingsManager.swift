//
//  SettingsManager.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/21/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

let numberOfAnalyzedTweetsKey = "numberOfAnalyzedTweets"

final class SettingsManager {
    
    /// Shared manager instance
    static let sharedManager = SettingsManager()
    
    /// Number of tweets to be retrieved and analyzed. Default value is 200.
    var numberOfAnalyzedTweets: Int = Defaults[numberOfAnalyzedTweetsKey].int ?? 200 {
        didSet {
            Defaults[numberOfAnalyzedTweetsKey] = numberOfAnalyzedTweets
        }
    }
}
