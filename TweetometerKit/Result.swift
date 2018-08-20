//
//  Result.swift
//  TweetometerKit
//
//  Created by Patrick Balestra on 8/20/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case error(TweetometerError)
}
