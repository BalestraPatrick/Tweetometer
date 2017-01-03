//
//  FabricSetUp.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 1/4/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import TwitterKit
import Instabug
import Keys

public enum Environment {
    case debug
    case testing
}

public class AppSetUp: NSObject {

    @discardableResult public init(environment: Environment = .debug) {
        Instabug.start(withToken: TweetscounterKeys().iNSTABUG_API_KEY(), invocationEvent: .twoFingersSwipeLeft)
        Twitter.sharedInstance().start(withConsumerKey: TweetscounterKeys().fABRIC_API_KEY(), consumerSecret: TweetscounterKeys().fABRIC_BUILD_SECRET())
        switch environment {
        case .debug:
            Fabric.with([Crashlytics.sharedInstance(), Twitter.sharedInstance()])
        case .testing:
            Fabric.with([Twitter.sharedInstance()])
        }
    }
}
