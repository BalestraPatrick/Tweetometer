//
//  TwitterKitInitializer.swift
//  Tweetometer
//
//  Created by Patrick Balestra on 8/13/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import TwitterKit

class TwitterKitInitializer: DependencyInitializer {

    func start() {
        TWTRTwitter.sharedInstance().start(withConsumerKey: Secrets.Twitter.consumerKey, consumerSecret: Secrets.Twitter.consumerSecret)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
}
