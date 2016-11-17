//
//  UserViewModel.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/21/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire
import RxDataSources
import NSObject_Rx

class UserViewModel: NSObject {
    
    enum TweetError: Error {
        case jsonError
        case userNotSet
    }
    
    var user: User?
    
    func userData() -> Observable<(String, String)> {
        return Observable.create { observer in
            guard let user = self.user else {
                observer.onError(TweetError.userNotSet)
                return Disposables.create { }
            }
            observer.onNext((user.name, user.screenName))
            observer.onCompleted()
            return Disposables.create { }
        }
    }
    
    func tweets() -> Observable<[Tweet]> {
        return Observable.create { observer in
            guard let user = self.user else {
                observer.onError(TweetError.jsonError)
                return Disposables.create { }
            }
            guard let tweets = user.tweets else {
                observer.onError(TweetError.jsonError)
                return Disposables.create { }
            }
            observer.onNext(tweets)
            observer.onCompleted()
            return Disposables.create { }
        }
    }
}
