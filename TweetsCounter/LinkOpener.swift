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
        urlComponents.host = "BalestraPatrick" // TODO: add name of currently logged in user here
    }
    
    func openUser(user: String) {
        urlComponents.path = "/user_profile/\(user)"
        guard let url = urlComponents.URL else { return }
        UIApplication.sharedApplication().openURL(url)
    }
    
    func openInSafari(url: NSURL) -> SFSafariViewController {
        return SFSafariViewController(URL: url)
    }
}