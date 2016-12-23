//
//  UserDetailsTableViewCell.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 5/1/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

class UserDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: ProfilePictureImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(_ user: User) {
        backgroundColor = UIColor.backgroundBlue()
        descriptionLabel.text = user.userDescription
        if let stringURL = user.profileImageURL {
            profileImage.af_setImage(withURL: URL(string: stringURL)!, placeholderImage: UIImage(asset: .placeholder))
        }
    }
}
