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

extension MenuPopOverViewController {
    
    func applyStyle() {
        tableView.alwaysBounceVertical = false
        view.backgroundColor = UIColor().menuDarkBlueColor()
        preferredContentSize = CGSize(width: 200, height: 44 * options.count)
    }
}

extension UserDetailViewController {
   
    func applyStyle() {
        view.backgroundColor = UIColor().backgroundBlueColor()
    }
}

extension HomeViewController: UIPopoverPresentationControllerDelegate {
 
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}

extension HomeViewController: UITabBarDelegate {
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
}

extension UINavigationBar {
    
    func applyStyle() {
        barTintColor = UIColor().backgroundBlueColor()
        tintColor = UIColor.whiteColor()
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
        self.dg_setPullToRefreshFillColor(UIColor().menuDarkBlueColor())
        self.dg_setPullToRefreshBackgroundColor(self.backgroundColor!)
    }
    
}
