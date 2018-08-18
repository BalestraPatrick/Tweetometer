//
//  JSONDecoder+Utils.swift
//  TweetometerKit
//
//  Created by Patrick Balestra on 8/18/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import Foundation

extension JSONDecoder {

    static var twitter: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.twitter)
        return decoder
    }()
}
