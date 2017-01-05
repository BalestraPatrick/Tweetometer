//
//  Analytics.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 1/5/17.
//  Copyright © 2017 Patrick Balestra. All rights reserved.
//

import Foundation
import Crashlytics

public enum Event {
    case login(success: Bool, error: [String: Any]?)
    case maximumNumberOfTweets(value: Int)
    case preferredTwitterClient(value: String)
}

public class Analytics {

    public static let shared = Analytics()

    private init() {}

    public func track(event: Event) {
        switch event {
        case let .login(success, error):
            Answers.logLogin(withMethod: nil, success: NSNumber(booleanLiteral: success), customAttributes: error)
        case let .maximumNumberOfTweets(value):
            Answers.logCustomEvent(withName: "Maximum Number of Tweets", customAttributes: ["value" : value])
        case let .preferredTwitterClient(value):
            Answers.logCustomEvent(withName: "Twitter Client", customAttributes: ["value" : value])
        }
    }
}
