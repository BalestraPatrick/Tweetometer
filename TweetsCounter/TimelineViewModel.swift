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
import RxDataSources
import Alamofire
import TwitterKit
import Stash
import NSObject_Rx

final class TimelineViewModel: NSObject {
    
    let stash: Stash?
    let settingsManager = SettingsManager.sharedManager
    var session = TwitterSession()
    
    var userID: String?
    
    override init() {
        do {
            stash = try Stash(name: cacheName, rootPath: NSTemporaryDirectory())
        } catch {
            stash = nil
        }
    }

    /// Request the profile information for the currently authenticated user.
    ///
    /// - returns: User object with all its fetched data.
    func requestProfileInformation() -> Observable<TWTRUser> {
        return Observable.create { observer -> Disposable in
            do {
                let userID = try self.session.isUserLoggedIn()
                Twitter.sharedInstance().sessionStore.sessionForUserID(userID)

                Twitter.sharedInstance()
                    .rx_loadUserWithID(userID, client: self.session.client!)
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
                    .addDisposableTo(self.rx_disposeBag)
            } catch {
                // Throw the error in the callback to present the login view controller
                observer.onError(TwitterRequestError.NotAuthenticated)
            }
            return AnonymousDisposable {}
        }
    }
    
    /// Request the user timeline for the currently authenticated user.
    ///
    /// - returns: Timeline object with all the users tweets.
    func requestTimeline(beforeID: String?) -> Observable<[User]> {
        return Observable.create { observer -> Disposable in
            print(self.session.client)
            if let client = self.session.client {
                Twitter.sharedInstance()
                    .rx_loadTimeline(self.settingsManager.numberOfAnalyzedTweets, beforeID: nil, client: client)
                    .subscribe(onNext: { timeline in
                        do {
                            let tweets: AnyObject = try NSJSONSerialization.JSONObjectWithData(timeline, options: .AllowFragments)
                            guard let tweetsArray = tweets as? Array<AnyObject> else { fatalError("Could not downcast to array") }
                            
                            let parser = TimelineParser(jsonTweets: tweetsArray)
                            if let t = parser.timeline {
                                let items = t.users
                                observer.onNext(items)
                                observer.onCompleted()
                            } else {
                                observer.onError(JSONError.UnknownError)
                            } 
                        } catch {
                            observer.onError(error)
                        }
                        }, onError: { error in
                            observer.onError(error)
                        }, onCompleted: nil, onDisposed: nil)
                    .addDisposableTo(self.rx_disposeBag)
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
            if let image = self.stash?[StashCacheIdentifier.profilePicture] as? UIImage {
                observer.onNext(image)
                observer.onCompleted()
            } else if let _ = self.session.client, let user = self.session.user {
                // Download profile image of the logged in user if not cached
                request(Method.GET, (user.profileImageLargeURL))
                    .flatMap {
                        $0.validate(statusCode: 200 ..< 300).rx_data()
                    }
                    .observeOn(MainScheduler.instance)
                    .subscribe {
                        guard let data = $0.element else { return }
                        let image = UIImage(data: data)!
                        self.stash?[StashCacheIdentifier.profilePicture] = image
                        observer.onNext(image)
                        observer.onCompleted()
                    }
                    .addDisposableTo(self.rx_disposeBag)
            } else {
                observer.onError(TwitterRequestError.NotAuthenticated)
            }
            return AnonymousDisposable {}
        }
    }
}
