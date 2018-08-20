//
//  UserInterfaceCustomization.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/2/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit

extension UIColor {
    
    public static func backgroundBlue() -> UIColor {
        return UIColor(red: 0.114, green: 0.631, blue: 0.949, alpha: 1.0)
    }

    public static func backgroundBlueSelected() -> UIColor {
        return UIColor(red: 0.114, green: 0.631, blue: 0.949, alpha: 0.5)
    }

    public static func mentionBlue() -> UIColor {
        return UIColor(red: 20/255, green: 118/255, blue: 180/255, alpha: 1.0)
    }

    public static func mentionBlueSelected() -> UIColor {
        return UIColor(red: 20/255, green: 118/255, blue: 180/255, alpha: 0.5)
    }

    public static func hashtagGray() -> UIColor {
        return UIColor(red: 139/255, green: 147/255, blue: 145/255, alpha: 1.0)
    }

    public static func hashtagGraySelected() -> UIColor {
        return UIColor(red: 139/255, green: 147/255, blue: 145/255, alpha: 0.5)
    }

    public static func bioGray() -> UIColor {
        return UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0)
    }

    public static func menuDarkBlue() -> UIColor {
        return UIColor(red: 0.223, green: 0.262, blue: 0.349, alpha: 1.0)
    }
    
    public static func transparentMenuDarkBlue() -> UIColor {
        return UIColor(red: 0.223, green: 0.262, blue: 0.349, alpha: 0.5)
    }

    public static func userCellSelected() -> UIColor {
        return UIColor(white: 0.9, alpha: 1.0)
    }

    public static func userCellEven() -> UIColor {
        return UIColor.white
    }

    public static func userCellOdd() -> UIColor {
        return UIColor(white: 0.97, alpha: 1.0)
    }
}
