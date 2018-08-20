//
//  TimelineUserCollectionViewCell.swift
//  Tweetometer
//
//  Created by Patrick Balestra on 8/18/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import UIKit
import TweetometerKit
import Kingfisher

class TimelineUserCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var profileImageView: ProfilePictureImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var followersCount: UILabel!
    @IBOutlet private var followingCount: UILabel!
    @IBOutlet private var tweetsCountLabel: UILabel!

    deinit {
        profileImageView.kf.cancelDownloadTask()
    }
    func configure(with element: TwitterTimelineElement) {
        profileImageView.kf.setImage(with: URL(string: element.user.profileImageUrl))
        nameLabel.text = "@".appending(element.user.screenName)
        usernameLabel.text = element.user.name
        followersCount.text = "\(element.user.followersCount) followers"
        followingCount.text = "\(element.user.friendsCount) following"
        tweetsCountLabel.text = "\(element.tweets.count) tweets"
    }
}
