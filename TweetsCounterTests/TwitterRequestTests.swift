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
import RxSwift

class TwitterRequestTests: XCTestCase {
    
    let userData = UserData()
    let timelineViewModel = TimelineViewModel()
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        _ = FabricSetUp(environment: .UnitTest)
        
        //        Twitter.sharedInstance().sessionStore.saveSessionWithAuthToken("344822973-En4QtFwZvvGqAtvKlD6QCLByphUm0p4EENWzyQNc", authTokenSecret: "TIeD7Y734A8E3zRGQeC3SQKFeVG67tCnaqwoTG8TGl2ql") { authSession, error in
        //            print("Session: \(authSession)")
        //            print("Error: \(error)")
        //        }
        
        stub(isMethodGET()) { request in
            print(request)
            let stubPath = OHPathForFile("users_show.json", self.dynamicType)
            return fixture(stubPath!, headers: ["Content-Type":"application/json"])
        }
    }
    
    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testLoadUserProfile() {
        
        let expectation = expectationWithDescription("Receive profile information successfully.")
                Twitter.sharedInstance().logInWithExistingAuthToken("344822973-En4QtFwZvvGqAtvKlD6QCLByphUm0p4EENWzyQNc", authTokenSecret: "TIeD7Y734A8E3zRGQeC3SQKFeVG67tCnaqwoTG8TGl2ql") { (session, error) -> Void in
//        Twitter.sharedInstance().sessionStore.saveSessionWithAuthToken("344822973-En4QtFwZvvGqAtvKlD6QCLByphUm0p4EENWzyQNc", authTokenSecret: "TIeD7Y734A8E3zRGQeC3SQKFeVG67tCnaqwoTG8TGl2ql") { session, error in
            print("Session: \(session)")
            print("Error: \(error)")
            //            if let _ = session {
            self.timelineViewModel
                .requestProfileInformation()
                .subscribe(onNext: { user in
                    print(user)
                    XCTAssertNotNil(user)
                    XCTAssertEqual(user.userID, self.userData.userID)
                    XCTAssertEqual(user.name, self.userData.name)
                    XCTAssertEqual(user.screenName, self.userData.screenName)
                    expectation.fulfill()
                    }, onError: { error in
                        XCTFail("Failed in requesting the profile information with error: \(error)")
                    }, onCompleted: nil, onDisposed: nil)
                .addDisposableTo(self.disposeBag)
            //            }
        }
        
        waitForExpectationsWithTimeout(15.0) { error in
            XCTAssertNil(error, "Failed expectation \(expectation) with error \(error)")
        }
    }
    
    //    func testLoadTimeline() {
    //        
    //        let expectation = expectationWithDescription("Receive the Twitter timeline.")
    //        
    //        _ = timelineViewModel
    //            .requestTimeline()
    //            .subscribe(onNext: { timeline in
    //                print(timeline)
    //                expectation.fulfill()
    //                }, onError: { error in
    //                    XCTFail("Failed in requesting the Twitter timeline with error: \(error)")
    //                }, onCompleted: nil, onDisposed: nil)
    //        
    //        waitForExpectationsWithTimeout(10.0) { error in
    //            XCTAssertNil(error, "Failed expectation \(expectation) with error \(error)")
    //        }
    //    }
}
