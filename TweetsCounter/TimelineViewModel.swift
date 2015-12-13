//
//  TimelineViewModel.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/2/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire
import Alamofire
import TwitterKit

class TimelineViewModel {

    var profilePicture: Dynamic<UIImage?> = Dynamic(nil)
    var userID: String = ""
    
    init() {
        
    }
    
    /**
     Check authentication of the current user to see if we can proceed to load the timeline.
     
     - parameter callback: Contains an optional authentication error.
     */
    func checkAuthentication(callback: (AuthenticationError?) -> Void) {
        do {
            let tweets = Tweets()
            userID = try tweets.checkSessionUserID()
            tweets.requestTweets(userID)
        }
        catch let error as AuthenticationError {
            callback(error)
        }
        catch {}
    }
    
    func requestProfilePicture() {
        
        let client = TWTRAPIClient(userID: userID)
        client.loadUserWithID(userID) { (user, error) in
            guard error == nil && user != nil else {
                print(error)
                return
            }
            // Download profile image of the logged in user
            _ = request(.GET, (user?.profileImageURL)!)
            .flatMap {
                $0
                    .validate(statusCode: 200 ..< 300)
                    .rx_data()
                }
                .observeOn(MainScheduler.sharedInstance)
                .subscribe {
                    guard let data = $0.element else { return }
                    self.profilePicture.value = UIImage(data: data)!
            }
        }
    }
}
