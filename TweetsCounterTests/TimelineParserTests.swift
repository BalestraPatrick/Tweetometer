//
//  TimelineParserTests.swift
//  
//
//  Created by Patrick Balestra on 2/5/16.
//
//

import XCTest
@testable import TweetsCounter

class TimelineParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParseTweets() {
        let jsonPath = NSBundle(forClass: self.dynamicType).pathForResource("timeline_tweets", ofType: "json")
        let timelineData = NSData(contentsOfFile: jsonPath!)!
        let tweets: AnyObject = try! NSJSONSerialization.JSONObjectWithData(timelineData, options: .AllowFragments)
        guard let tweetsArray = tweets as? Array<AnyObject> else { XCTFail("Could not downcast to array"); return }
        
        let parser = TimelineParser(jsonTweets: tweetsArray)
        if let t = parser.timeline {
            let users = t.users
            XCTAssertEqual(users.count, 1)
            let user = users.first!
            XCTAssertEqual(user.userID, 7213362)
            XCTAssertEqual(user.followersCount, 6149)
            XCTAssertEqual(user.followingCount, 402)
            XCTAssertEqual(user.statusesCount, 92563)
            XCTAssertEqual(user.screenName, "Javi")
            XCTAssertEqual(user.name, "Javi.swift")
            XCTAssertEqual(user.description, "@Fabric Swift Engineer @Twitter. Previously @Pebble. Functional Programming enthusiast. Rubik\'s Cube speed solver. Chess player. Made @watch_chess.")
            XCTAssertEqual(user.profileImageURL, NSURL(string: "https://pbs.twimg.com/profile_images/551121750100955136/ZphnhOpS_bigger.jpeg"))
            let tweets = user.tweets
            XCTAssertEqual(tweets?.count, 1)
            let tweet = tweets?.first!
            XCTAssertEqual(tweet?.tweetID, 695645083652075520)
            let createdAt = NSDate(timeIntervalSince1970: 1454689687)
            XCTAssertEqual(tweet?.createdAt, createdAt)
            XCTAssertEqual(tweet?.text, "RT @moonpolysoft: Good interview question: explain the movie Primer to me.")
            XCTAssertEqual(tweet?.language, "en")
            XCTAssertEqual(tweet?.screenName, "Javi")
            XCTAssertNotNil(tweet?.author)
        } else {
            XCTFail("Failed in parsing timeline object with parser object: \(parser)")
        }
    }
    
}
