//
//  TweetsCounterTests.swift
//  TweetsCounterTests
//
//  Created by Patrick Balestra on 10/19/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

@testable import TweetsCounter
import XCTest
import TwitterKit
import OHHTTPStubs

class TwitterRequestTests: XCTestCase {
    
    let userData = UserData()
    let timelineViewModel = TimelineViewModel()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testLoadUserProfileSuccessfully() {
        
        let expectation = expectationWithDescription("Receive profile information successfully.")
        
        _ = timelineViewModel.requestProfileInformation()
            .subscribe(onNext: { user in
                XCTAssertNil(user)
                XCTAssertEqual(user.userID, self.userData.userID)
                XCTAssertEqual(user.name, self.userData.name)
                XCTAssertEqual(user.screenName, self.userData.screenName)
                expectation.fulfill()
                }, onError: { error in
                    XCTFail("Failed in requesting the profile information with error: \(error)")
                }, onCompleted: nil, onDisposed: nil)
        
        waitForExpectationsWithTimeout(10.0) { error in
            XCTAssertNil(error, "Failed expectation \(expectation) with error \(error)")
        }
    }
    
    func testLoadUserProfileFailed() {
        
        let expectation = expectationWithDescription("Receive error when the request fails.")
        
        _ = timelineViewModel.requestProfileInformation()
            .subscribe(onNext: { user in
                XCTFail("Failed in requesting the profile information with error: \(user)")
                }, onError: { error in
                    expectation.fulfill()
                }, onCompleted: nil, onDisposed: nil)
        
        waitForExpectationsWithTimeout(10.0) { error in
            XCTAssertNil(error, "Failed expectation \(expectation) with error \(error)")
        }
        
        stub(isPath(TwitterEndpoints().profile.host!)) { request in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.CFURLErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
    }
}
