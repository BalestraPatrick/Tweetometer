//
//  NSAttributedString+User.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/3/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

extension NSAttributedString {

    class func followingAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)]
        let attributedString = NSMutableAttributedString(string: String(count), attributes: numberAttributes)
        let followingAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.thin)]
        let followingWord = NSAttributedString(string: " Following", attributes: followingAttributes)
        attributedString.append(followingWord)
        return attributedString
    }

    class func followersAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)]
        let attributedString = NSMutableAttributedString(string: String(count), attributes: numberAttributes)
        let followesAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.thin)]
        let followersWord = NSAttributedString(string: " Followers", attributes: followesAttributes)
        attributedString.append(followersWord)
        return attributedString
    }

    class func tweetsAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)]
        let attributedString = NSMutableAttributedString(string: String(count), attributes: numberAttributes)
        let tweetsAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)]
        let word = count > 1 ? " Tweets" : " Tweet"
        let tweetsWord = NSAttributedString(string: word, attributes: tweetsAttributes)
        attributedString.append(tweetsWord)
        return attributedString
    }

    class func totalTweetsCountAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)]
        let wordAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                              NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)]
        let attributedString = NSMutableAttributedString(string: "Total\n", attributes: wordAttributes)
        let word = NSAttributedString(string: String(count), attributes: numberAttributes)
        attributedString.append(word)
        return attributedString
    }

    class func tweetsCountAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)]
        let wordAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                              NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)]
        let tweet = count > 1 ? " Tweets" : " Tweet"
        let attributedString = NSMutableAttributedString(string: "\(tweet)\n", attributes: wordAttributes)
        let word = NSAttributedString(string: String(count), attributes: numberAttributes)
        attributedString.append(word)
        return attributedString
    }

    class func retweetsCountAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)]
        let wordAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                              NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)]
        let retweet = count > 1 ? " Retweets" : " Retweet"
        let attributedString = NSMutableAttributedString(string: "\(retweet)\n", attributes: wordAttributes)
        let word = NSAttributedString(string: String(count), attributes: numberAttributes)
        attributedString.append(word)
        return attributedString
    }

    class func repliesCountAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)]
        let wordAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                              NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)]
        let reply = count > 1 ? " Replies" : " Reply"
        let attributedString = NSMutableAttributedString(string: "\(reply)\n", attributes: wordAttributes)
        let word = NSAttributedString(string: String(count), attributes: numberAttributes)
        attributedString.append(word)
        return attributedString
    }
}
