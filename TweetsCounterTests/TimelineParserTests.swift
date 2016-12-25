//
//  TimelineParserTests.swift
//  
//
//  Created by Patrick Balestra on 2/5/16.
//
//

import XCTest
import RealmSwift
@testable import TweetsCounter
@testable import TweetometerKit

class TimelineParserTests: XCTestCase {

    var realm: Realm!

    override func setUp() {
        super.setUp()
         realm = DataManager.realm()
    }
    
    override func tearDown() {
        super.tearDown()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func testParseTweets() {
        let jsonPath = Bundle(for: type(of: self)).path(forResource: "timeline_tweets", ofType: "json")
        let timelineData = try! Data(contentsOf: URL(fileURLWithPath: jsonPath!))
        let tweets: AnyObject = try! JSONSerialization.jsonObject(with: timelineData, options: .allowFragments) as AnyObject
        guard let tweetsArray = tweets as? JSONArray else { XCTFail("Could not downcast to array"); return }

        let parser = TimelineParser()
        parser.parse(tweetsArray)
        let users = realm.objects(User.self)
        print(realm.objects(Tweet.self).count)

        XCTAssertEqual(users.count, 1)
        let user = users.first!
        XCTAssertEqual(user.userId, "7213362")
        XCTAssertEqual(user.followersCount, 6149)
        XCTAssertEqual(user.followingCount, 402)
        XCTAssertEqual(user.statusesCount, 92563)
        XCTAssertEqual(user.screenName, "Javi")
        XCTAssertEqual(user.name, "Javi.swift")
        XCTAssertEqual(user.userDescription, "@Fabric Swift Engineer @Twitter. Previously @Pebble. Functional Programming enthusiast. Rubik\'s Cube speed solver. Chess player. Made @watch_chess.")
        XCTAssertEqual(user.profileImageURL, "https://pbs.twimg.com/profile_images/551121750100955136/ZphnhOpS_bigger.jpeg")
        XCTAssertEqual(user.tweets.count, 1)
        let tweet = user.tweets.first!
        XCTAssertEqual(tweet.tweetId, "695645083652075520")
        let createdAt = Date(timeIntervalSince1970: 1454689687)
        XCTAssertEqual(tweet.createdAt, createdAt)
        XCTAssertEqual(tweet.text, "RT @moonpolysoft: Good interview question: explain the movie Primer to me.")
        XCTAssertEqual(tweet.language, "en")
        XCTAssertEqual(user.screenName, "Javi")
    }
}
