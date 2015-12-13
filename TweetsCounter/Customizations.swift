//
//  UserInterfaceCustomization.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/2/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func applyCustomization() {
        barTintColor = UIColor.whiteColor()
        titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blackColor()]
        setBackgroundImage(UIImage(), forBarMetrics: .Default)
        shadowImage = UIImage()
    }
}

extension UIColor {
    
    func twitterBlueColor() -> UIColor {
        return UIColor(red: 0.114, green: 0.631, blue: 0.949, alpha: 1.9)
    }
}