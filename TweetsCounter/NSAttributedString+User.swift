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
        let numberAttributes = [NSForegroundColorAttributeName: UIColor.black,
                                NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)]
        let attributedString = NSMutableAttributedString(string: String(count), attributes: numberAttributes)
        let followingAttributes = [NSForegroundColorAttributeName: UIColor.black,
                                   NSFontAttributeName: UIFont.systemFont(ofSize: 11, weight: UIFontWeightThin)]
        let followingWord = NSAttributedString(string: " Following", attributes: followingAttributes)
        attributedString.append(followingWord)
        return attributedString
    }

    class func followersAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSForegroundColorAttributeName: UIColor.black,
                                NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)]
        let attributedString = NSMutableAttributedString(string: String(count), attributes: numberAttributes)
        let followesAttributes = [NSForegroundColorAttributeName: UIColor.black,
                                   NSFontAttributeName: UIFont.systemFont(ofSize: 11, weight: UIFontWeightThin)]
        let followersWord = NSAttributedString(string: " Followers", attributes: followesAttributes)
        attributedString.append(followersWord)
        return attributedString
    }

    class func tweetsAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSForegroundColorAttributeName: UIColor.black,
                                NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)]
        let attributedString = NSMutableAttributedString(string: String(count), attributes: numberAttributes)
        let tweetsAttributes = [NSForegroundColorAttributeName: UIColor.black,
                                   NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)]
        let word = count > 1 ? " Tweets" : " Tweet"
        let tweetsWord = NSAttributedString(string: word, attributes: tweetsAttributes)
        attributedString.append(tweetsWord)
        return attributedString
    }

    class func totalTweetsCountAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSForegroundColorAttributeName: UIColor.white,
                                NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)]
        let wordAttributes = [NSForegroundColorAttributeName: UIColor.white,
                                NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)]
        let attributedString = NSMutableAttributedString(string: "Total\n", attributes: wordAttributes)
        let word = NSAttributedString(string: String(count), attributes: numberAttributes)
        attributedString.append(word)
        return attributedString
    }

    class func tweetsCountAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSForegroundColorAttributeName: UIColor.white,
                                NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)]
        let wordAttributes = [NSForegroundColorAttributeName: UIColor.white,
                              NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)]
        let tweet = count > 1 ? " Tweets" : " Tweet"
        let attributedString = NSMutableAttributedString(string: "\(tweet)\n", attributes: wordAttributes)
        let word = NSAttributedString(string: String(count), attributes: numberAttributes)
        attributedString.append(word)
        return attributedString
    }

    class func retweetsCountAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSForegroundColorAttributeName: UIColor.white,
                                NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)]
        let wordAttributes = [NSForegroundColorAttributeName: UIColor.white,
                              NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)]
        let retweet = count > 1 ? " Retweets" : " Retweet"
        let attributedString = NSMutableAttributedString(string: "\(retweet)\n", attributes: wordAttributes)
        let word = NSAttributedString(string: String(count), attributes: numberAttributes)
        attributedString.append(word)
        return attributedString
    }

    class func repliesCountAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSForegroundColorAttributeName: UIColor.white,
                                NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)]
        let wordAttributes = [NSForegroundColorAttributeName: UIColor.white,
                              NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)]
        let reply = count > 1 ? " Replies" : " Reply"
        let attributedString = NSMutableAttributedString(string: "\(reply)\n", attributes: wordAttributes)
        let word = NSAttributedString(string: String(count), attributes: numberAttributes)
        attributedString.append(word)
        return attributedString
    }
}
