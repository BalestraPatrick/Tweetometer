//
//  LinkOpenerTweetTests.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/26/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import XCTest
@testable import TweetsCounter

class LinkOpenerTweetTests: XCTestCase {

    let opener = LinkOpener()

    func test_openTweet_TweetbotApp() {
        opener.client = .tweetbot
        opener.open(user: "BalestraPatrick")
        XCTAssertEqual(opener.urlComponents.string!, "tweetbot:/user_profile/BalestraPatrick", "Tweetbot URL Scheme is wrong")
    }

    func test_openTweet_TwitterApp() {
        opener.client = .twitter
        opener.open(user: "BalestraPatrick")
        XCTAssertEqual(opener.urlComponents.string!, "twitter:/user%3Fscreen_name=BalestraPatrick", "Twitter URL Scheme is wrong")
    }

    class MockCoordinator: UserDetailCoordinatorDelegate {
        var url: URL?

        func presentSafari(_ url: URL) {
            self.url = url
        }
        func open(user: String) { }
        func open(hashtag: String) { }
    }

    func test_openTweet_Safari() {
        opener.client = .web
        opener.open(user: "BalestraPatrick")
        let mockCoordinator = MockCoordinator()
        opener.coordinator = mockCoordinator
        opener.open(user: "BalestraPatrick")
        XCTAssertEqual(mockCoordinator.url, URL(string: "https://www.twitter.com/BalestraPatrick"))
    }
}
