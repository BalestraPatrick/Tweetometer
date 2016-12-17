//
//  FabricSetUp.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/27/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import SafariServices

private let twitterScheme = "twitter"
private let tweetbotScheme = "tweetbot"

class LinkOpener {
    
    /// Store preferred user client from the settings
    var client = SettingsManager.sharedManager.preferredTwitterClient

    /// User detail coordinator needed to present a SafariViewController on the current view controller
    var coordinator: UserDetailCoordinator?

    /// Describes the URL Scheme components
    var urlComponents = URLComponents()

    /// Returns true if the Tweetbot app is available on device.
    var isTweetbotAvailable: Bool = {
        return UIApplication.shared.canOpenURL(URL(string: "\(tweetbotScheme)://")!)
    }()

    /// Returns true if the Twitter app is available on device.
    var isTwitterAvailable: Bool = {
        return UIApplication.shared.canOpenURL(URL(string: "\(twitterScheme)://")!)
    }()

    /// Returns true if Safari is available.
    var isSafariAvailable: Bool = {
        return UIApplication.shared.canOpenURL(URL(string: "http://www.google.com")!)
    }()
    
    /// Opens the a Twitter user in the default client.
    ///
    /// - parameter user: Screen-name of the user.
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
                coordinator.presentSafari(url)
                return
            }
        }
                
        // Try to open the URL
        if let stringURL = urlComponents.string!.removingPercentEncoding, let url = URL(string: stringURL), isSafariAvailable {
            UIApplication.shared.open(url)
        }
    }

    func open(hashtag: String) {
        let url = URL(string: "https://twitter.com/search?q=\(hashtag)")
        switch client {
        case .tweetbot:
            urlComponents.scheme = tweetbotScheme
            urlComponents.path = "tweetbot://search?query=\(hashtag)"
            break
        case .twitter:
            // TODO
            break
        case .web:
            if let url = url, let coordinator = coordinator {
                coordinator.presentSafari(url)
                return
            }
        }

        // Try to open the URL
        if let url = url, isSafariAvailable {
            UIApplication.shared.open(url)
        }
    }

    func open(mention: String) {
        let url = URL(string: "https://twitter.com/search?q=\(mention)")
        switch client {
        case .tweetbot:
            urlComponents.scheme = tweetbotScheme
            urlComponents.path = "tweetbot://user_profile/\(mention)"
            break
        case .twitter:
            // TODO
            break
        case .web:
            if let url = url, let coordinator = coordinator {
                coordinator.presentSafari(url)
                return
            }
        }

        // Try to open the URL
        if let url = url, isSafariAvailable {
            UIApplication.shared.open(url)
        }
    }

    /// Initializes a Safari view controller object to present in the future.
    ///
    /// - parameter url: URL of the page to load in Safari.
    ///
    /// - returns: The view controller to be used.
    internal func openInSafari(_ url: URL) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
}
