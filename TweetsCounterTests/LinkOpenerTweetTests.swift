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
    let tweetId = "812705528329760768"

    func test_openTweet_TweetbotApp() {
        opener.client = .tweetbot
        opener.open(tweet: tweetId)
        XCTAssertEqual(opener.urlComponents.string!, "tweetbot:/status/\(tweetId)", "Tweetbot URL Scheme is wrong")
    }

    func test_openTweet_TwitterApp() {
        opener.client = .twitter
        opener.open(tweet: tweetId)
        XCTAssertEqual(opener.urlComponents.string!.removingPercentEncoding, "twitter:/status?id=\(tweetId)", "Twitter URL Scheme is wrong")
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
        opener.open(tweet: tweetId)
        XCTAssertEqual(mockCoordinator.url, URL(string: "https://www.twitter.com/statuses/\(tweetId)"))
    }
}
