//
//  PerformanceLogger.swift
//  TweetometerKit
//
//  Created by Patrick Balestra on 8/17/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import Foundation
import os.signpost

public enum PerformanceLogType {
    case begin
    case end
    case event

    var signpostType: OSSignpostType {
        guard #available(iOS 12.0, *) else { fatalError("Programmer Error: this should never be invoked without checking that the minimum iOS version matches.") }
        switch self {
        case .begin: return .begin
        case .end: return .end
        case .event: return .event
        }
    }
}

public func logPerformance(_ type: PerformanceLogType, name: StaticString, log: OSLog = .default, format: StaticString? = nil, arguments: CVarArg...) {
    guard #available(iOS 12.0, *) else { return }
    // TODO: Use OSLog.disable in release mode
    if let format = format {
        os_signpost(type.signpostType, log: log, name: name, signpostID: OSSignpostID(log: log), format, arguments)
    } else {
        os_signpost(type.signpostType, log: log, name: name, signpostID: OSSignpostID(log: log))
    }
}
