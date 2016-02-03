//
//  ApplicationStyle.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 1/31/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func applyStyle() {
        barTintColor = UIColor.whiteColor()
        titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(18, weight: 0.1)]
        setBackgroundImage(UIImage(), forBarMetrics: .Default)
        shadowImage = UIImage()
        backgroundColor = UIColor().backgroundBlueColor()
        
        
    }
}

extension UINavigationItem {
    
    func applyStyle() {
        // TODO: subclass UIView and instantiate from here
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 40))
        let halfWidth = view.frame.size.height / 2
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: halfWidth))
        titleLabel.text = "Who is Tweeting?"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        view.addSubview(titleLabel)
        
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: halfWidth, width: view.frame.size.width, height: halfWidth))
        subtitleLabel.text = "In the last 200 tweets of your timeline"
        subtitleLabel.textAlignment = .Center
        subtitleLabel.textColor = UIColor.whiteColor()
        subtitleLabel.font = UIFont.systemFontOfSize(12, weight: 0.05)
        view.addSubview(subtitleLabel)
        titleView = view
    }
}

extension UITableView {
    
    func applyStyle() {
        backgroundView = nil
        backgroundColor = UIColor.clearColor()
        tableFooterView = UIView()
    }
}

extension HomeViewController {
    
    func applyStyle() {
        view.backgroundColor = UIColor().backgroundBlueColor()
        navigationController?.navigationBar.applyStyle()
        tableView.applyStyle()
        navigationItem.applyStyle()
    }
    
}