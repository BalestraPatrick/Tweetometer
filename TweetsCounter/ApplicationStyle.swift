//
//  ApplicationStyle.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 1/31/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

extension HomeViewController {
    
    func applyStyle() {
        view.backgroundColor = UIColor().backgroundBlueColor()
        navigationController?.navigationBar.applyStyle()
        tableView.separatorStyle = .None
        tableView.applyStyle()
    }
    
    func setTitleViewContent(numberOfTweets: Int) {
        titleLabel.text = "Tweetometer"
        subtitleLabel.text = "In the last \(numberOfTweets) tweets of your timeline"
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
    }
}
