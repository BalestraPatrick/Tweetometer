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
        navigationController?.navigationBar.applyStyle()
        tableView.separatorStyle = .none
        tableView.applyStyle()
        titleLabel.text = "Your Timeline Stats"
    }

    func set(screenName: String) {
        subtitleLabel.text = "@\(screenName)"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension HomeViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension HomeViewController: UITabBarDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
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
        view.backgroundColor = .menuDarkBlue()
        preferredContentSize = CGSize(width: 200, height: 44 * options.count)
    }
}

extension UserDetailViewController {
    
    func applyStyle() {
        navigationController?.navigationBar.applyStyle()
        tableView.separatorStyle = .none
        tableView.applyStyle()
        tableView.backgroundColor = .backgroundBlue()
    }

    func setTitleViewContent(_ name: String, screenName: String) {
        titleLabel.text = name
        subtitleLabel.text = "@\(screenName)"
    }
}
