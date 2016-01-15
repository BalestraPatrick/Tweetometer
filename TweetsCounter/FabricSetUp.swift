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
import Keys

class FabricSetUp: NSObject {
    
    override init() {
        Twitter.sharedInstance().startWithConsumerKey(TweetscounterKeys().fABRIC_API_KEY(), consumerSecret: TweetscounterKeys().fABRIC_BUILD_SECRET())
        Fabric.with([Crashlytics.sharedInstance(), Twitter.sharedInstance()])        
    }
}
