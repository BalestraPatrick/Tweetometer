//
//  UserDetailsTableViewCell.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 5/1/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import TweetometerKit
import ActiveLabel

class UserDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: ProfilePictureImageView!
    @IBOutlet weak var descriptionLabel: ActiveLabel!

    weak var coordinator: UserDetailCoordinator!

    func configure(_ user: User, coordinator: UserDetailCoordinator) {
        backgroundColor = .backgroundBlue()
        descriptionLabel.text = user.userDescription
        if let stringURL = user.profileImageURL {
            profileImage.af_setImage(withURL: URL(string: stringURL)!, placeholderImage: UIImage(asset: .placeholder))
        }

        self.coordinator = coordinator

        // Set up Tweet label
        descriptionLabel.configureBio(URLHandler: {
            self.coordinator.presentSafari($0)
        }, hashtagHandler: {
            self.coordinator.open(hashtag: $0)
        }, mentionHandler: {
            self.coordinator.open(user: $0)
        })
    }
}
