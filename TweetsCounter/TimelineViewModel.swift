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
    var session = TwitterSession()
    let disposebag = DisposeBag()
    
    var userID: String?
    
    init() {
    }
    
    /// Request the profile information for the currently authenticated user.
    ///
    /// - returns: User object with all its fetched data.
    func requestProfileInformation() -> Observable<TWTRUser> {
        return Observable.create { observer -> Disposable in
            do {
                let userID = try self.session.checkSessionUserID()
                
                Twitter.sharedInstance()
                    .rx_loadUserWithID(userID, client: self.session.client!)
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { user in
                        self.session.user = user
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
        }
    }
    
    /// Request the user timeline for the currently authenticated user.
    ///
    /// - returns: Timeline object with all the tweets.
    func requestTimeline() -> Observable<Timeline> {
        return Observable.create { observer -> Disposable in
            if let client = self.session.client {
                Twitter.sharedInstance()
                    .rx_loadTimeline(1, client: client)
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { timeline in
                        do {
                            let tweets: Array = try NSJSONSerialization.JSONObjectWithData(timeline, options: .AllowFragments) as! Array<AnyObject>
                            // TODO: build timeline
                            //                            let timeline = Timeline(u
                            
                            for tweet in tweets {
                                let user = tweet["user"]
                                //                                let tweetObject = Tweet(tweet: <#T##TWTRTweet#>)
                                if let u = user {
                                    
                                    print(u!["screen_name"])
                                }
                                
                            }
                            observer.onNext(Timeline())
                            observer.onCompleted()
                        } catch {
                            observer.onError(error)
                        }
                        }, onError: { error in
                            observer.onError(error)
                        }, onCompleted: nil, onDisposed: nil)
                    .addDisposableTo(self.disposebag)
            } else {
                observer.onError(TwitterRequestError.NotAuthenticated)
            }
            return AnonymousDisposable {}
        }
    }
    
    /// Fetch from local cache or download the authenticated user's profile picture.
    ///
    /// - returns: User profile image.
    func requestProfilePicture() -> Observable<UIImage> {
        return Observable.create { observer -> Disposable in
            if let _ = self.session.client, let user = self.session.user {
                // Download profile image of the logged in user if not cached
                request(Method.GET, (user.profileImageLargeURL)!)
                    .flatMap {
                        $0.validate(statusCode: 200 ..< 300).rx_data()
                    }
                    .observeOn(MainScheduler.instance)
                    .subscribe {
                        guard let data = $0.element else { return }
                        let image = UIImage(data: data)!
                        self.stash[StashCacheIdentifier.profilePicture] = image
                        observer.onNext(image)
                        observer.onCompleted()
                    }.addDisposableTo(self.disposebag)
            } else if let image = self.stash[StashCacheIdentifier.profilePicture] as? UIImage {
                observer.onNext(image)
                observer.onCompleted()
            } else {
                observer.onError(TwitterRequestError.NotAuthenticated)
            }
            return AnonymousDisposable {}
        }
    }
}
