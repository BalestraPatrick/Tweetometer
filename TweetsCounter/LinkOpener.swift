//
//  FabricSetUp.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/27/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import TweetometerKit
import SafariServices

private let twitterScheme = "twitter"
private let tweetbotScheme = "tweetbot"

class LinkOpener {
    
    /// Store preferred user client from the settings.
    var client: TwitterClient {
        return Settings.shared.preferredTwitterClient
    }

    /// User detail coordinator needed to present a SafariViewController on the current view controller.
    weak var coordinator: Coordinator?

    /// Describes the URL Scheme components.
    var urlComponents = URLComponents()

    /// Returns true if the Tweetbot app is available on the device.
    var isTweetbotAvailable: Bool = {
        return UIApplication.shared.canOpenURL(URL(string: "\(tweetbotScheme)://")!)
    }()

    /// Returns true if the Twitter app is available on the device.
    var isTwitterAvailable: Bool = {
        return UIApplication.shared.canOpenURL(URL(string: "\(twitterScheme)://")!)
    }()

    /// Returns true if Safari is available.
    var isSafariAvailable: Bool = {
        return UIApplication.shared.canOpenURL(URL(string: "http://www.google.com")!)
    }()
    
    /// Opens a user profile in the default client.
    ///
    /// - parameter user: The screen name of the user.
    func open(user: String) {
        switch client {
        case .tweetbot:
            urlComponents.scheme = tweetbotScheme
            urlComponents.path = "/user_profile/\(user)"
        case .twitter:
            urlComponents.scheme = twitterScheme
            urlComponents.path = "/user?screen_name=\(user)"
        case .web:
            let url = URL(string: "https://www.twitter.com/\(user)")
            if let url = url, let coordinator = coordinator {
                return coordinator.presentSafari(url)
            }
        }

        // Open URL scheme
        open(components: urlComponents)
    }

    /// Opens an hashtag in the default client.
    ///
    /// - Parameter hashtag: The hashtag to be opened.
    func open(hashtag: String) {
        switch client {
        case .tweetbot:
            urlComponents.scheme = tweetbotScheme
            urlComponents.path = "/search?query=\(hashtag)"
        case .twitter:
            urlComponents.scheme = twitterScheme
            urlComponents.path = "/search?query=\(hashtag)"
        case .web:
            let url = URL(string: "https://www.twitter.com/search?q=\(hashtag)")
            if let url = url, let coordinator = coordinator {
                return coordinator.presentSafari(url)
            }
        }

        // Open URL scheme
        open(components: urlComponents)
    }

    /// Opens a tweet in the default client.
    ///
    /// - Parameter tweet: The tweet id to be opened.
    func open(tweet: String) {
        switch client {
        case .tweetbot:
            urlComponents.scheme = tweetbotScheme
            urlComponents.path = "/status/\(tweet)"
        case .twitter:
            urlComponents.scheme = twitterScheme
            urlComponents.path = "/status?id=\(tweet)"
        case .web:
            let url = URL(string: "https://www.twitter.com/statuses/\(tweet)")
            if let url = url, let coordinator = coordinator {
                return coordinator.presentSafari(url)
            }
        }

        // Open URL scheme
        open(components: urlComponents)
    }

    /// Initializes a Safari view controller object to present in the future.
    ///
    /// - parameter url: URL of the page to load in Safari.
    ///
    /// - returns: The view controller to be used.
    internal func openInSafari(_ url: URL) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    /// Builds the URL from the given components to open a third-party app via URL scheme.
    ///
    /// - Parameter components: The URL components taht describe the URL scheme.
    private func open(components: URLComponents) {
        // Create valid url and do all checks
        guard let string = components.string, let escapedString = string.removingPercentEncoding, let url = URL(string: escapedString), isSafariAvailable else {
            return print("URL invalid")
        }
        UIApplication.shared.open(url)
    }
}
