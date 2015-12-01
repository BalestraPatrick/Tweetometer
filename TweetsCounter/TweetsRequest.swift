//
//  Request.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/31/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift
import TwitterKit

struct TweetsRequest {
    
    private var client: TWTRAPIClient

    init() {
        let store = Twitter.sharedInstance().sessionStore
        print(store.existingUserSessions())
        
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            client = TWTRAPIClient(userID: userID)
            print(userID)
        } else {
            client = TWTRAPIClient()
        }
        
    }
}