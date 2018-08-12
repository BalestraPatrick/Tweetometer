//
//  MenuOptionsTests.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/5/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import XCTest
@testable import TweetometerKit

class MenuOptionsTests: XCTestCase {
    
    func testDataSource() {
        let options = MenuDataSource().options
        
        XCTAssertEqual(options.count, 4)
        XCTAssertEqual(options[0].title, "Refresh")
        XCTAssertEqual(options[0].image, "refresh")
        XCTAssertEqual(options[1].title, "Share")
        XCTAssertEqual(options[1].image, "share")
        XCTAssertEqual(options[2].title, "Logout")
        XCTAssertEqual(options[2].image, "logout")
        XCTAssertEqual(options[3].title, "Settings")
        XCTAssertEqual(options[3].image, "settings")
    }
}
