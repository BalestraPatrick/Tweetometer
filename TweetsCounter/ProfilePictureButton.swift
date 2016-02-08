//
//  ProfilePictureButton.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/1/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import RxSwift
import NSObject_Rx

final class ProfilePictureButton: UIButton {
    
    var image = UIImage() {
        didSet {
            self.setBackgroundImage(image, forState: .Normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = frame.size.width / 2
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = 1.0
        imageView?.contentMode = .ScaleAspectFit
        layer.masksToBounds = true
        accessibilityLabel = "Profile Picture"
    }
    
}