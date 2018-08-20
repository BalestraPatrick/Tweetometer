//
//  TweetometerError.swift
//  TweetometerKit
//
//  Created by Patrick Balestra on 8/20/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import Foundation

public enum TweetometerError: Error {
    case notAuthenticated
    case invalidResponse
    case rateLimitExceeded
    case noInternetConnection
    case failedAnalysis
    case unknown(Error)

    static func from(_ error: Error) -> TweetometerError {
        switch (error as NSError).code {
        case 88: return .rateLimitExceeded
        case -1009: return .noInternetConnection
        default: return .unknown(error)
        }
    }
}
