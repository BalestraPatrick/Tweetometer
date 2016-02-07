//
//  MenuOptionsTests.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/5/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import XCTest
@testable import TweetsCounter

class MenuOptionsTests: XCTestCase {
    
    func testDataSource() {
        let options = MenuOptionsDataSource().options
        
        XCTAssertEqual(options.count, 3)
        XCTAssertEqual(options[0].title, "Refresh")
        XCTAssertEqual(options[0].image, "refresh")
        XCTAssertEqual(options[1].title, "Logout")
        XCTAssertEqual(options[1].image, "logout")
        XCTAssertEqual(options[2].title, "About")
        XCTAssertEqual(options[2].image, "info")
    }
}
