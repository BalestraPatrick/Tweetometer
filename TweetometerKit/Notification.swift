//
//  Notification.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/27/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import Foundation

public enum Notification: String {
    case requestCompleted = "Tweetometer.RequestCompleted"
    case requestStarted = "Tweetometer.RequestStarted"
}

extension NSNotification.Name {

    public static func requestCompleted() -> NSNotification.Name {
        return NSNotification.Name(Notification.requestCompleted.rawValue)
    }

    public static func requestStarted() -> NSNotification.Name {
        return NSNotification.Name(Notification.requestStarted.rawValue)
    }
}
