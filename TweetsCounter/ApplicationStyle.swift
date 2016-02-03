//
//  ApplicationStyle.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 1/31/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh

extension HomeViewController {
    
    func applyStyle() {
        view.backgroundColor = UIColor().backgroundBlueColor()
        navigationController?.navigationBar.applyStyle()
        tableView.separatorStyle = .None
        tableView.applyStyle()
        
    }
    
    func setTitleViewContent(numberOfTweets: Int) {
        titleLabel.text = "Tweetometer"
        subtitleLabel.text = "Of the last \(numberOfTweets) tweets of your timeline"
    }
    
}

extension UINavigationBar {
    
    func applyStyle() {
        barTintColor = UIColor().backgroundBlueColor()
        titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(18, weight: 0.1)]
        setBackgroundImage(UIImage(), forBarMetrics: .Default)
        shadowImage = UIImage()
        translucent = false
        backgroundColor = UIColor().backgroundBlueColor()
    }
}

extension UITableView {
    
    func applyStyle() {
        backgroundView = nil
        backgroundColor = UIColor.clearColor()
        tableFooterView = UIView()
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.whiteColor()
        self.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            // Add your logic here
            // Do not forget to call dg_stopLoading() at the end
            self!.dg_stopLoading()
            }, loadingView: loadingView)
        self.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        self.dg_setPullToRefreshBackgroundColor(self.backgroundColor!)
    }
    
}
