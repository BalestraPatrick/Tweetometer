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

    enum TweetError: ErrorType {
        case JSONError
        case UserNotSet
    }
    
    var user: User?
    
    func userData() -> Observable<(String, String)> {
        return Observable.create { observer in
            guard let user = self.user else {
                observer.onError(TweetError.UserNotSet)
                return AnonymousDisposable { }
            }
            observer.onNext((user.name, user.screenName))
            observer.onCompleted()
            return AnonymousDisposable { }
        }
    }
    
    func tweets() -> Observable<[AnimatableSectionModel<String, Tweet>]> {
        return Observable.create { observer in
            guard let user = self.user else {
                observer.onError(TweetError.JSONError)
                return AnonymousDisposable { }
            }
            guard let tweets = user.tweets else {
                observer.onError(TweetError.JSONError)
                return AnonymousDisposable { }
            }
            observer.onNext([AnimatableSectionModel(model: "", items: tweets)])
            observer.onCompleted()
            return AnonymousDisposable { }
        }
    }
}
