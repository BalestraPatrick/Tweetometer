//
//  UsersRefreshViewAnimator.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/24/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import Foundation
import PullToRefresh

class UsersRefreshViewAnimator: RefreshViewAnimator {

    private let refreshView: UsersRefreshView

    init(refreshView: UsersRefreshView) {
        self.refreshView = refreshView
    }

    func animate(_ state: State) {
        // animate refreshView according to state
        switch state {
        case .initial:
            // do inital layout for elements
            refreshView.activityIndicator.startAnimating()
            break
        case .releasing(let progress):
            // animate elements according to progress
            break
        case .loading:
            // start loading animations
            break
        case .finished:
            // show some finished state if needed
            refreshView.activityIndicator.stopAnimating()
            break
        }
    }
}
