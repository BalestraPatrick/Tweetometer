//
//  ProfilePictureImageView.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 5/2/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

class ProfilePictureImageView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = frame.size.width / 2
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = 1.0
        layer.masksToBounds = true
    }
    
}
