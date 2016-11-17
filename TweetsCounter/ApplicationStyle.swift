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
        barStyle = .black
        barTintColor = UIColor.backgroundBlueColor()
        tintColor = UIColor.white
        titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: 0.1)]
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = false
        backgroundColor = UIColor.backgroundBlueColor()
    }
}

extension UITableView {
    
    func applyStyle() {
        backgroundView = nil
        backgroundColor = UIColor.clear
        tableFooterView = UIView()
    }
    
}
