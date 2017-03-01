//
//  NetworkActivityIndicatorManager.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/27/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import TweetometerKit

class NetworkingActivityIndicatorManager {

    var numberOfPendingRequests = 0
    let center = NotificationCenter.default

    init() {
        center.addObserver(self, selector: #selector(requestCompleted), name: NSNotification.Name.requestCompleted(), object: nil)
        center.addObserver(self, selector: #selector(requestStarted), name: NSNotification.Name.requestStarted(), object: nil)
    }

    @objc func requestStarted() {
        numberOfPendingRequests += 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    @objc func requestCompleted() {
        numberOfPendingRequests -= 1
        if numberOfPendingRequests == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
