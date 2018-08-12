//
//  TweetTableViewCell.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/21/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import TweetometerKit

class TweetTableViewCell: UITableViewCell {
    
//    @IBOutlet weak var tweetLabel: ActiveLabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetsCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!

    weak var coordinator: UserDetailCoordinator!

    var index = 0 {
        didSet {
            backgroundColor = index % 2 == 0 ? .userCellEven() : .userCellOdd()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.textColor = .black
        retweetsCountLabel.textColor = .black
        likesCountLabel.textColor = .black

        // Set up Tweet label
//        tweetLabel.configureTweet(URLHandler: {
//            self.coordinator.presentSafari($0)
//        }, hashtagHandler: {
//            self.coordinator.open(hashtag: $0)
//        }, mentionHandler: {
//            self.coordinator.open(user: $0)
//        })
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            backgroundColor = .userCellSelected()
        } else {
            backgroundColor = index % 2 == 0 ? .userCellEven() : .userCellOdd()
        }
    }
    
    func configure(_ tweet: Tweet, indexPath: IndexPath, coordinator: UserDetailCoordinator) {
        tweetLabel.text = tweet.text
        dateLabel.text = tweet.createdAt.tweetDateFormatted()
        retweetsCountLabel.text = "\(tweet.retweetsCount)"
        likesCountLabel.text = "\(tweet.likesCount)"
        index = indexPath.row
        self.coordinator = coordinator
    }
}
