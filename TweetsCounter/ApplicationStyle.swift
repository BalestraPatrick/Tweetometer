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
        barStyle = .Black
        barTintColor = UIColor.backgroundBlueColor()
        tintColor = UIColor.whiteColor()
        titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(18, weight: 0.1)]
        setBackgroundImage(UIImage(), forBarMetrics: .Default)
        shadowImage = UIImage()
        translucent = false
        backgroundColor = UIColor.backgroundBlueColor()
    }
}

extension UITableView {
    
    func applyStyle() {
        backgroundView = nil
        backgroundColor = UIColor.clearColor()
        tableFooterView = UIView()
    }
    
}
