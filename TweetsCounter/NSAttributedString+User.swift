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
        let numberAttributes = [NSForegroundColorAttributeName : UIColor.black,
                                NSFontAttributeName : UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)]
        let attributedString = NSMutableAttributedString(string: String(count), attributes: numberAttributes)
        let followersAttributes = [NSForegroundColorAttributeName : UIColor.black,
                                   NSFontAttributeName : UIFont.systemFont(ofSize: 11, weight: UIFontWeightThin)]
        let followersWord = NSAttributedString(string: " Following", attributes: followersAttributes)
        attributedString.append(followersWord)
        return attributedString
    }

    class func followersAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSForegroundColorAttributeName : UIColor.black,
                                NSFontAttributeName : UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)]
        let attributedString = NSMutableAttributedString(string: String(count), attributes: numberAttributes)
        let followersAttributes = [NSForegroundColorAttributeName : UIColor.black,
                                   NSFontAttributeName : UIFont.systemFont(ofSize: 11, weight: UIFontWeightThin)]
        let followersWord = NSAttributedString(string: " Followers", attributes: followersAttributes)
        attributedString.append(followersWord)
        return attributedString
    }

    class func tweetsAttributes(with count: Int) -> NSAttributedString {
        let numberAttributes = [NSForegroundColorAttributeName : UIColor.black,
                                NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)]
        let attributedString = NSMutableAttributedString(string: String(count), attributes: numberAttributes)
        let followersAttributes = [NSForegroundColorAttributeName : UIColor.black,
                                   NSFontAttributeName : UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)]
        let word = count > 1 ? " Tweets" : " Tweet"
        let followersWord = NSAttributedString(string: word, attributes: followersAttributes)
        attributedString.append(followersWord)
        return attributedString
    }
}
