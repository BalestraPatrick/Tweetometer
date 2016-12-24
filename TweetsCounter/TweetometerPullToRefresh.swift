//
//  TweetometerPullToRefresh.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/24/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import PullToRefresh

class TweetometerPullToRefresh: PullToRefresh {

    convenience init() {
        let refreshView = Bundle(for: type(of: self)).loadNibNamed("UsersRefreshView", owner: nil, options: nil)!.first as! UsersRefreshView
        let animator = UsersRefreshViewAnimator(refreshView: refreshView)
        self.init(refreshView: refreshView, animator: animator, height: 30, position: .top)
    }
}
