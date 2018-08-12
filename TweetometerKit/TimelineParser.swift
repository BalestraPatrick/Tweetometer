//
//  TimelineParser.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 1/28/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import Foundation

typealias JSON = [String: AnyHashable]
typealias JSONArray = [JSON]

public final class TimelineParser {

    /// The Id of the oldest retrieved tweet.
    var maxId: String?

    /// Parse the JSON tweets into Tweet objects.
    ///
    /// - Parameter tweets: The array of JSON tweets.
    func parse(_ tweets: JSONArray) {

    }
}
