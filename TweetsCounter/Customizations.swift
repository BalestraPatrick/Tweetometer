//
//  UserInterfaceCustomization.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/2/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func backgroundBlueColor() -> UIColor {
        return UIColor(red: 0.114, green: 0.631, blue: 0.949, alpha: 1.0)
    }
    
    func menuDarkBlueColor() -> UIColor {
        return UIColor(red: 0.223, green: 0.262, blue: 0.349, alpha: 1.0)
    }
    
    func transparentMenuDarkBlueColor() -> UIColor {
        return UIColor(red: 0.223, green: 0.262, blue: 0.349, alpha: 0.5)
    }
    
}

extension NSDateFormatter {

    static func twitterDateFormatter() -> NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        return formatter
    }
}

// Fix for bug in  DGElasticPullToRefresh: https://github.com/gontovnik/DGElasticPullToRefresh/issues/24#issuecomment-182840115
extension UIScrollView {
    func dg_stopScrollingAnimation() {}
}