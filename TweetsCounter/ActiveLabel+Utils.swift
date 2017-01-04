//
//  ActiveLabel+Utils.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 1/4/17.
//  Copyright © 2017 Patrick Balestra. All rights reserved.
//

import Foundation
import ActiveLabel

extension ActiveLabel {

    /// Configure the active label to display a tweet with the correct colors.
    ///
    /// - Parameters:
    ///   - URLHandler: The function to call when a URL is tapped.
    ///   - hashtagHandler: The function to call when an hashtag is tapped.
    ///   - mentionHandler: The function to call when a mention is tapped.
    func configureTweet(URLHandler: @escaping (URL) -> (), hashtagHandler: @escaping (String) -> (), mentionHandler: @escaping (String) -> ()) {
        customize { label in
            label.textColor = .black
            label.mentionColor = .mentionBlue()
            label.mentionSelectedColor = .mentionBlueSelected()
            label.URLColor = .backgroundBlue()
            label.URLSelectedColor = .backgroundBlueSelected()
            label.hashtagColor = .hashtagGray()
            label.hashtagSelectedColor = .hashtagGraySelected()
            label.handleURLTap(URLHandler)
            label.handleHashtagTap(hashtagHandler)
            label.handleMentionTap(mentionHandler)
        }
    }

    /// Configure the active label to display a user bio with the correct colors.
    ///
    /// - Parameters:
    ///   - URLHandler: The function to call when a URL is tapped.
    ///   - hashtagHandler: The function to call when an hashtag is tapped.
    ///   - mentionHandler: The function to call when a mention is tapped.
    func configureBio(URLHandler: @escaping (URL) -> (), hashtagHandler: @escaping (String) -> (), mentionHandler: @escaping (String) -> ()) {
        customize { label in
            label.textColor = .white
            label.mentionColor = .bioGray()
            label.mentionSelectedColor = .mentionBlueSelected()
            label.URLColor = .bioGray()
            label.URLSelectedColor = .backgroundBlueSelected()
            label.hashtagColor = .bioGray()
            label.hashtagSelectedColor = .hashtagGraySelected()
            label.handleURLTap(URLHandler)
            label.handleHashtagTap(hashtagHandler)
            label.handleMentionTap(mentionHandler)
        }
    }
}
