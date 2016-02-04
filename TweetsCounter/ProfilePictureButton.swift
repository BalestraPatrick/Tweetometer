//
//  ProfilePictureButton.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/1/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import RxSwift

final class ProfilePictureButton: UIButton {
    
    var disposeBag = DisposeBag()
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
    }
    
}