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
        opener.open(tweet: "812705528329760768")
        XCTAssertEqual(opener.urlComponents.string!, "tweetbot:/status/812705528329760768", "Tweetbot URL Scheme is wrong")
    }

    func test_openTweet_TwitterApp() {
        opener.client = .twitter
        opener.open(tweet: "812705528329760768")
        XCTAssertEqual(opener.urlComponents.string!.removingPercentEncoding, "twitter:/status?id=812705528329760768", "Twitter URL Scheme is wrong")
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
        let mockCoordinator = MockCoordinator()
        opener.coordinator = mockCoordinator
        opener.open(tweet: "812705528329760768")
        XCTAssertEqual(mockCoordinator.url, URL(string: "https://www.twitter.com/statuses/812705528329760768"))
    }
}
