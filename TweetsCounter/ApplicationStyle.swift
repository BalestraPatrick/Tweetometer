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
        barTintColor = .backgroundBlue()
        tintColor = .white
        titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: 0.1)]
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = false
        backgroundColor = .backgroundBlue()
    }
}

extension UITableView {
    
    func applyStyle() {
        backgroundView = nil
        backgroundColor = .clear
        tableFooterView = UIView()
    }
}

extension DateFormatter {

    static let updateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
}

extension Date {

    func updateString() -> String {
        if self.compare(Date(timeIntervalSince1970: 0)) == ComparisonResult.orderedSame {
            return "✖️"
        }
        return DateFormatter.updateFormatter.string(from: self)
    }
}
