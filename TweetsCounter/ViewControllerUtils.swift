//
//  HomeViewControllerUtils.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/21/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

extension HomeViewController {
    
    func applyStyle() {
        view.backgroundColor = UIColor.backgroundBlueColor()
        navigationController?.navigationBar.applyStyle()
        tableView.separatorStyle = .None
        tableView.applyStyle()
        
    }
    
    func setTitleViewContent(numberOfTweets: Int) {
        titleLabel.text = "Tweetometer"
        subtitleLabel.text = "Of the last \(numberOfTweets) tweets of your timeline"
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

extension HomeViewController: SettingsDelegate {
    
    func numberOfAnalyzedTweetsDidChange(value: Int) {
        setTitleViewContent(value)
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
        view.backgroundColor = UIColor.backgroundBlueColor()
    }
}