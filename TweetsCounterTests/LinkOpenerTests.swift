//
//  LinkOpenerTests.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 4/30/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import XCTest
@testable import TweetsCounter

class LinkOpenerTests: XCTestCase {
    
    let opener = LinkOpener()
    
    func testTweetbotURLScheme() {
        opener.client = .tweetbot
        opener.open(user: "BalestraPatrick")
        XCTAssertEqual(opener.urlComponents.string!, "tweetbot:/user_profile/BalestraPatrick", "Tweetbot URL Scheme is wrong")
    }
    
    func testTwitterURLScheme() {
        opener.client = .twitter
        opener.open(user: "BalestraPatrick")
        XCTAssertEqual(opener.urlComponents.string!, "twitter:/user%3Fscreen_name=BalestraPatrick", "Twitter URL Scheme is wrong")
    }
    
    func testOpenInSafari() {
        XCTAssertNotNil(opener.openInSafari(URL(string: "http://www.google.com")!))
    }
    
}
