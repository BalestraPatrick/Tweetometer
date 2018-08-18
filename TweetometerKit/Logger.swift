//
//  Logger.swift
//  TweetometerKit
//
//  Created by Patrick Balestra on 8/17/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import Foundation
import os.log

public enum Subsystem {
    public static let twitterSession = OSLog(subsystem: "com.patrickbalestra.tweetometer.twitterSession", category: "twitterSession")
}

public func log(_ message: StaticString, log: OSLog = .default, args: CVarArg...) {
    os_log(message, log: log, type: .default, args)
}
