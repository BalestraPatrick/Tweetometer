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
    }
    
}