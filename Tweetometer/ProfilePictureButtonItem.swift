//
//  ProfilePictureButton.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/1/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit

final class ProfilePictureButtonItem: UIBarButtonItem {

    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))

    private override init() {
        super.init()
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    private func setUp() {
        customView = imageView
        imageView.layer.cornerRadius = imageView.bounds.size.width / 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1.0
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        accessibilityLabel = "Profile Picture"
    }
}
