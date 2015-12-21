//
//  RxTwitter.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/20/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import TwitterKit
import RxSwift

extension Twitter {
    
    ///  Load user information via the Twitter API.
    ///
    ///  - parameter userID:  ID of the user account to be fetched.
    ///  - parameter session: Session to load the request.
    ///
    ///  - returns: An Observable containing the user object.
    func rx_loadUserWithID(userID: String, session: TwitterSession) -> Observable<TWTRUser> {
        return create { (observer: AnyObserver<TWTRUser>) -> Disposable in
            session.client?.loadUserWithID(userID) { user, error in
                if let e = error {
                    observer.onError(e)
                } else {
                    observer.on(.Next(user!))
                    observer.on(.Completed)
                }
            }
            return AnonymousDisposable { }
        }
    }
}