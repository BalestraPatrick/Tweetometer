//
//  Request.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/31/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public struct TweetsRequest {

    public init() {
        let url = NSURL(string: TwitterAPI().userTimelineURL)!
        
//        let observable = Alamofire.request(Method.GET, url).rx_response()
//        observable.observeOn(MainScheduler.sharedInstance)
//            .subscribe(onNext: { json in
//                
//                print(json)
//                
//                }, onError: { error in
//                    print(error)
//            })
    }
}