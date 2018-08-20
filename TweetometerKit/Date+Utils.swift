//
//  Date+Utils.swift
//  TweetometerKit
//
//  Created by Patrick Balestra on 8/20/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import Foundation

extension Date {

    public func tweetDateFormatted() -> String {
        let minutesComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit.minute, from: self, to: Date(), options: []).minute
        guard let minutes = minutesComponents else { return "" }
        if minutes < 60 {
            return "\(minutes)m"
        } else if minutes < 60 * 24 {
            return "\(minutes / 60)h"
        } else {
            return "\(minutes / (60 * 24))d"
        }
    }
}
