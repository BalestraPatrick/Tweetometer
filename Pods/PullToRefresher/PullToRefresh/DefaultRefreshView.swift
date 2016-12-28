//
//  DefaultRefreshView.swift
//  PullToRefreshDemo
//
//  Created by Serhii Butenko on 26/7/16.
//  Adapted by Patrick Balestra on 28/12/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

public class DefaultRefreshView: UIView {

    fileprivate(set) lazy var activityIndicator: UIActivityIndicatorView! = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.addSubview(activityIndicator)
        return activityIndicator
    }()

    fileprivate(set) lazy var label: UILabel! = {
        let label = UILabel()
        label.text = "Updated 10.24pm - 100 Tweets analyzed"
        if #available(iOS 8.2, *) {
            label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin)
        }
        self.addSubview(label)
        return label
    }()

    override public func layoutSubviews() {
        centerActivityIndicator()
        setupFrame(in: superview)

        super.layoutSubviews()
    }

    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        centerActivityIndicator()
        setupFrame(in: superview)
    }
}

private extension DefaultRefreshView {

    func setupFrame(in newSuperview: UIView?) {
        guard let superview = newSuperview else { return }

        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: superview.frame.width, height: frame.height)
    }

    func centerActivityIndicator() {
        activityIndicator.frame = CGRect(x: 25, y: 10, width: 20, height: 20)
        label.frame = CGRect(x: 55, y: 10, width: frame.width-65, height: 20)
    }
}
