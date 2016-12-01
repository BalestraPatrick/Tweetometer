//
//  ProfilePictureButton.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/1/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit

final class ProfilePictureButton: UIButton {
    
    var image = UIImage() {
        didSet {
            self.setBackgroundImage(image, for: UIControlState())
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = frame.size.width / 2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
        imageView?.contentMode = .scaleAspectFit
        layer.masksToBounds = true
        accessibilityLabel = "Profile Picture"
    }
    
}
