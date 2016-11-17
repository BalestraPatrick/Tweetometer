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
        tableView.separatorStyle = .none
        tableView.applyStyle()
    }
    
    func setTitleViewContent(_ numberOfTweets: Int) {
        titleLabel.text = "Tweetometer"
        subtitleLabel.text = "Of the last \(numberOfTweets) tweets of your timeline"
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
}

extension HomeViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

extension HomeViewController: UITabBarDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
}

extension HomeViewController: SettingsDelegateTweets {
    
    func numberOfAnalyzedTweetsDidChange(_ value: Int) {
        setTitleViewContent(value)
    }
}

extension SettingsViewController: SettingsDelegateClient {
    
    func twitterClientDiDChange(_ value: TwitterClient) {
        twitterClientControl.selectedSegmentIndex = TwitterClient.toIndex(value)
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
    
    func setTitleViewContent(_ name: String, screenName: String) {
        titleLabel.text = name
        subtitleLabel.text = "@\(screenName)"
    }
}
