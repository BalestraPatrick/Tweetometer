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
import Stash

class TimelineViewModel {
    
    let stash = try! Stash(name: cacheName, rootPath: NSTemporaryDirectory())
    let disposebag = DisposeBag()
    
    var userID: String?
    var loggedInUser: TWTRUser?
    
    init() {
        
    }
    
    /// Request the profile information for the currently authenticated user.
    ///
    /// - returns: User object with all its fetched data.
    func requestProfileInformation() -> Observable<TWTRUser> {
        return create({ observer -> Disposable in
            do {
                let session = TwitterSession()
                let userID = try session.checkSessionUserID()
                
                Twitter.sharedInstance()
                    .rx_loadUserWithID(userID, session: session)
                    .observeOn(MainScheduler.sharedInstance)
                    .subscribe(onNext: { user in
                        self.loggedInUser = user
                        observer.onNext(user)
                        observer.onCompleted()
                        }, onError: { error in
                            // Present error in case of no internet access and with information contained in the NSError object
                            print("Failed in requesting user data with error: \(error)!")
                            // TODO: Use Error Type
                            observer.onError(error)
                        }, onCompleted: nil, onDisposed: nil)
                    .addDisposableTo(self.disposebag)
            }
            catch {
                // Throw the error in the callback to present the login view controller
                observer.onError(TwitterRequestError.NotAuthenticated)
            }
            return AnonymousDisposable {}
        })
    }
    
    /// Fetch from local cache or download the authenticated user's profile picture.
    ///
    /// - returns: User profile image.
    func requestProfilePicture() -> Observable<UIImage> {
        return create({ observer -> Disposable in
            if self.loggedInUser == nil {
                observer.onError(TwitterRequestError.NotAuthenticated)
            } else if let image = self.stash[StashCacheIdentifier.profilePicture] as? UIImage {
                observer.onNext(image)
                observer.onCompleted()
            } else {
                // Download profile image of the logged in user if not cached
                request(Method.GET, (self.loggedInUser?.profileImageLargeURL)!)
                    .flatMap {
                        $0.validate(statusCode: 200 ..< 300).rx_data()
                    }
                    .observeOn(MainScheduler.sharedInstance)
                    .subscribe {
                        guard let data = $0.element else { return }
                        let image = UIImage(data: data)!
                        self.stash[StashCacheIdentifier.profilePicture] = image
                        observer.onNext(image)
                        observer.onCompleted()
                    }.addDisposableTo(self.disposebag)
            }
            return AnonymousDisposable {}
        })
    }
}
