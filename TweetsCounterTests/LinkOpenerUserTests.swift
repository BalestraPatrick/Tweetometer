//
//  LinkOpenerTests.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 4/30/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import XCTest
@testable import TweetsCounter

class LinkOpenerUserTests: XCTestCase {
    
    let opener = LinkOpener()
    let user = "BalestraPatrick"
    
    func test_openUser_TweetbotApp() {
        opener.client = .tweetbot
        opener.open(user: user)
        XCTAssertEqual(opener.urlComponents.string!, "tweetbot:/user_profile/\(user)", "Tweetbot URL Scheme is wrong")
    }
    
    func test_openUser_TwitterApp() {
        opener.client = .twitter
        opener.open(user: user)
        XCTAssertEqual(opener.urlComponents.string!, "twitter:/user%3Fscreen_name=\(user)", "Twitter URL Scheme is wrong")
    }

    class MockCoordinator: UserDetailCoordinatorDelegate {
        var url: URL?

        func presentSafari(_ url: URL) {
            self.url = url
        }
        func open(user: String) { }
        func open(hashtag: String) { }
    }

    func test_openUser_Safari() {
        opener.client = .web
        let mockCoordinator = MockCoordinator()
        opener.coordinator = mockCoordinator
        opener.open(user: user)
        XCTAssertEqual(mockCoordinator.url, URL(string: "https://www.twitter.com/\(user)"))
    }
}
