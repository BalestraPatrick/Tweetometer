//
//  DateFormatter+Utils.swift
//  TweetometerKit
//
//  Created by Patrick Balestra on 8/18/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import Foundation

extension DateFormatter {

    static var twitter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        return formatter
    }()
}
