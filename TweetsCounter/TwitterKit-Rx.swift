//
//  TwitterKit-Rx.swift
//
//  Created by Patrick Balestra on 1/8/16.
//
//

import Foundation
import RxSwift
import TwitterKit

private enum TwitterError: Error {
    case unknown
}

public extension Twitter {
    
    /// Triggers user authentication with Twitter.
    ///
    /// - parameter client:  API client used to load the request.
    ///
    /// - returns: The Twitter user session.
    public func rx_logIn(_ client: TWTRAPIClient) -> Observable<TWTRSession> {
        return Observable.create { (observer: AnyObserver<TWTRSession>) -> Disposable in
            self.logIn { session, error in
                guard let session = session else {
                    observer.onError(error ?? TwitterError.unknown)
                    return
                }
                observer.onNext(session)
                observer.onCompleted()
            }
            return Disposables.create { }
        }
    }
    
    /// Loads a Twitter User.
    ///
    /// - parameter userID:  ID of the user account to be fetched.
    /// - parameter client:  API client used to load the request.
    ///
    /// - returns: An Observable of the user.
    public func rx_loadUserWithID(_ userID: String, client: TWTRAPIClient) -> Observable<TWTRUser> {
        return Observable.create { (observer: AnyObserver<TWTRUser>) -> Disposable in
            client.loadUser(withID: userID) { user, error in
                guard let user = user else {
                    observer.onError(error ?? TwitterError.unknown)
                    return
                }
                observer.onNext(user)
                observer.onCompleted()
            }
            return Disposables.create { }
        }
    }
    
    /// Loads a single Tweet from the network or cache.
    ///
    /// - parameter tweetID:  ID of the tweet to be retrieved.
    /// - parameter client:   API client used to load the request.
    ///
    /// - returns: A single tweet.
    public func rx_loadTweetWithID(_ tweetID: String, client: TWTRAPIClient) -> Observable<TWTRTweet> {
        return Observable.create { (observer: AnyObserver<TWTRTweet>) -> Disposable in
            client.loadTweet(withID: tweetID, completion: { tweet, error in
                guard let tweet = tweet else {
                    observer.onError(error ?? TwitterError.unknown)
                    return
                }
                observer.onNext(tweet)
                observer.onCompleted()
            })
            return Disposables.create { }
        }
    }
    
    /// Loads a series of Tweets in a batch.
    ///
    /// - parameter ids:     IDs of the tweets to be retrieved.
    /// - parameter client:  API client used to load the request.
    ///
    /// - returns: An array of Tweets.
    public func rx_loadTweetsWithIDs(_ ids: Array<String>, client: TWTRAPIClient) -> Observable<Array<TWTRTweet>> {
        return Observable.create { (observer: AnyObserver<Array<TWTRTweet>>) -> Disposable in
            client.loadTweets(withIDs: ids, completion: { tweets, error in
                guard let tweets = tweets else {
                    observer.onError(error ?? TwitterError.unknown)
                    return
                }
                observer.onNext(tweets)
                observer.onCompleted()
            })
            return Disposables.create { }
        }
    }
    
    /// Load the user timeline.
    ///
    /// - parameter count:   The number of tweets to retrieve contained in the timeline.
    /// - parameter client:  API client used to load the request.
    ///
    /// - returns: The timeline data.
    public func rx_loadTimeline(_ count: Int, beforeID: String?, client: TWTRAPIClient) -> Observable<Data> {
        return Observable.create { (observer: AnyObserver<Data>) -> Disposable in
            let httpMethod = "GET"
            let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
            var parameters = ["count" : String(count), "include_entities" : "false", "exclude_replies" : "false"]
            if let beforeID = beforeID {
                parameters["beforeID"] = beforeID
            }

            _ = self.rx_URLRequestWithMethod(httpMethod, url: url, parameters: parameters as [String : AnyObject], client: client)
                .subscribe(
                    onNext: { data in
                        guard let timeline = data as? Data else {
                            observer.onError(TwitterError.unknown)
                            return
                        }
                        observer.onNext(timeline)
                        observer.onCompleted()
                    }, onError: { error in
                        observer.onError(error)
                    }, onCompleted: nil, onDisposed: nil)
            return Disposables.create { }
        }
    }
    
    /// Returns a signed URL request.
    ///
    /// - parameter method:     HTTP method of the request.
    /// - parameter URL:        Full Twitter endpoint API URL.
    /// - parameter parameters: Request parameters.
    /// - parameter client:  API client used to load the request.
    ///
    /// - returns: The received object.
    public func rx_URLRequestWithMethod(_ method: String, url: String, parameters: [String : AnyObject], client: TWTRAPIClient)
        -> Observable<AnyObject> {
            return Observable.create { (observer: AnyObserver<AnyObject>) -> Disposable in
                let request = client.urlRequest(withMethod: method, url: url, parameters: parameters, error: nil)
                client.sendTwitterRequest(request) { response, data, connectionError in
                    guard let data = data else {
                        observer.onError(connectionError ?? TwitterError.unknown)
                        return
                    }
                    observer.onNext(data as AnyObject)
                    observer.onCompleted()
                }
                return Disposables.create { }
            }
    }
    
}
