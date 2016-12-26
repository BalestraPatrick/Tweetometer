//
//  LinkOpenerHashtagTests.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/26/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import XCTest
@testable import TweetsCounter

class LinkOpenerHashtagTests: XCTestCase {

    let opener = LinkOpener()

    func test_openHashtag_TweetbotApp() {
        opener.client = .tweetbot
        opener.open(hashtag: "appbuilders17")
        XCTAssertEqual(opener.urlComponents.string!.removingPercentEncoding, "tweetbot:/search?query=appbuilders17", "Tweetbot URL Scheme is wrong")
    }

    func test_openHashtag_TwitterApp() {
        opener.client = .twitter
        opener.open(hashtag: "appbuilders17")
        XCTAssertEqual(opener.urlComponents.string!.removingPercentEncoding, "twitter:/search?query=appbuilders17", "Twitter URL Scheme is wrong")
    }

    class MockCoordinator: UserDetailCoordinatorDelegate {
        var url: URL?

        func presentSafari(_ url: URL) {
            self.url = url
        }
        func open(user: String) { }
        func open(hashtag: String) { }
    }

    func test_openHashtag_Safari() {
        opener.client = .web
        let mockCoordinator = MockCoordinator()
        opener.coordinator = mockCoordinator
        opener.open(hashtag: "appbuilders17")
        XCTAssertEqual(mockCoordinator.url, URL(string: "https://www.twitter.com/search?q=appbuilders17"))
    }
}
