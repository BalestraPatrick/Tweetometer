//
//  FabricSetUp.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/27/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

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
        urlComponents.path = "BalestraPatrick/timeline"
    }
    
    func openUser(user: User) {
        print(urlComponents.URL)
        
        guard let url = urlComponents.URL else { return }
        UIApplication.sharedApplication().openURL(url)
    }
}