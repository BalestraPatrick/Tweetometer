//
//  ProfilePictureButton.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/1/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit

final class ProfilePictureButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = self.frame.size.width / 2
        self.imageView?.contentMode = .ScaleAspectFit
        self.layer.masksToBounds = true
    }
    
}