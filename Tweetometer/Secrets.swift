//
//  Secrets.swift
//  Tweetometer
//
//  Created by Patrick Balestra on 8/13/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import Foundation

enum Secrets {

    enum Twitter {
        static let consumerKey = Secrets.envVariable(name: "TWITTER_CONSUMER_KEY")
        static let consumerSecret = Secrets.envVariable(name: "TWITTER_CONSUMER_SECRET")
    }

    private static func envVariable(name: String) -> String {
        guard let value = Bundle.main.infoDictionary?[name] as? String else {
            fatalError("Missing environment variable `\(name)`.")
        }
        return value
    }
}
