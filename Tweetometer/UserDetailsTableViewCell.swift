//
//  UserDetailsTableViewCell.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 5/1/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import TweetometerKit
//import ActiveLabel

class UserDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: ProfilePictureImageView!
//    @IBOutlet weak var descriptionLabel: ActiveLabel!
    @IBOutlet weak var totalTweetsCountLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var retweetsCountLabel: UILabel!
    @IBOutlet weak var repliesCountLabel: UILabel!

    weak var coordinator: UserDetailCoordinator!

    var totalTweetsCount: Int = 0 {
        didSet {
            totalTweetsCountLabel.attributedText = NSAttributedString.totalTweetsCountAttributes(with: totalTweetsCount)
        }
    }

    var tweetsCount: Int = 0 {
        didSet {
            tweetsCountLabel.attributedText = NSAttributedString.tweetsCountAttributes(with: tweetsCount)
        }
    }

    var retweetsCount: Int = 0 {
        didSet {
            retweetsCountLabel.attributedText = NSAttributedString.retweetsCountAttributes(with: retweetsCount)
        }
    }

    var repliesCount: Int = 0 {
        didSet {
            repliesCountLabel.attributedText = NSAttributedString.repliesCountAttributes(with: repliesCount)
        }
    }

    func configure(_ user: User, coordinator: UserDetailCoordinator) {
        backgroundColor = .backgroundBlue()
//        descriptionLabel.text = user.userDescription
//        if let stringURL = user.profileImageURL {
//            profileImage.af_setImage(withURL: URL(string: stringURL)!, placeholderImage: UIImage(asset: .placeholder))
//        }

//        totalTweetsCount = user.tweetsCount()
//        retweetsCount = user.retweetedTweetsCount()
//        repliesCount = user.repliesTweetsCount()
//        tweetsCount = totalTweetsCount - retweetsCount - repliesCount

        self.coordinator = coordinator

        // Set up Tweet label
//        descriptionLabel.configureBio(URLHandler: {
//            self.coordinator.presentSafari($0)
//        }, hashtagHandler: {
//            self.coordinator.open(hashtag: $0)
//        }, mentionHandler: {
//            self.coordinator.open(user: $0)
//        })
    }
}
