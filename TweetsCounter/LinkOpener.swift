//
//  FabricSetUp.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/27/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import SafariServices

enum AppOpener: String {
    case Twitter = "twitter"
    case Tweetbot = "tweetbot"
}

class LinkOpener {
    
    var defaultApp: AppOpener = .Tweetbot {
        didSet {
            urlComponents.scheme = defaultApp.rawValue
        }
    }
    
    var urlComponents = NSURLComponents()
    
    init() {
        urlComponents.scheme = defaultApp.rawValue
    }
    
    func openUser(user: String) {
        switch defaultApp {
        case .Tweetbot:
            // Tweetbot URL scheme requires the currently logged in user sccreen_name
            urlComponents.host = "BalestraPatrick" // TODO: add name of currently logged in user here
            urlComponents.path = "/user_profile/\(user)"
        case .Twitter:
            // Twitter URL scheme doesn't require the currently logged in user sccreen_name
            urlComponents.host = ""
            urlComponents.path = "/user?screen_name=\(user)"
        }

        if let stringURL = urlComponents.string?.stringByRemovingPercentEncoding, let url = NSURL(string: stringURL) {
            UIApplication.sharedApplication().openURL(url)
        } else {
//            TODO
        }
    }
    
    func openInSafari(url: NSURL) -> SFSafariViewController {
        return SFSafariViewController(URL: url)
    }
}