//
//  UITableView+Screenshot.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/28/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

extension UITableView {

    var topUsersImage: UIImage? {
        // Get top 5 users (or less if not available)
        let rowsCount = CGFloat(min(numberOfRows(inSection: 0), 5))
        let rowHeight = rectForRow(at: IndexPath(row: 0, section: 0)).height

        UIGraphicsBeginImageContext(CGSize(width: contentSize.width, height: rowHeight * rowsCount))
        scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        layer.render(in: UIGraphicsGetCurrentContext()!)

        defer { UIGraphicsEndImageContext() }
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            return image
        }
        return nil
    }
}
