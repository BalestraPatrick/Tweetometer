//
//  TweetTableViewCell.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/21/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import ActiveLabel
import TweetometerKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetLabel: ActiveLabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetsCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!

    weak var coordinator: UserDetailCoordinatorDelegate!

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
        tweetLabel.customize { label in
            label.textColor = .black
            label.mentionColor = .mentionBlue()
            label.mentionSelectedColor = .mentionBlueSelected()
            label.URLColor = .backgroundBlue()
            label.URLSelectedColor = .backgroundBlueSelected()
            label.hashtagColor = .hashtagGray()
            label.hashtagSelectedColor = .hashtagGraySelected()
            label.handleURLTap {
                self.coordinator.presentSafari($0)
            }
            label.handleHashtagTap {
                self.coordinator.open(hashtag: $0)
            }
            label.handleMentionTap {
                self.coordinator.open(user: $0)
            }
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            backgroundColor = .userCellSelected()
        } else {
            backgroundColor = index % 2 == 0 ? .userCellEven() : .userCellOdd()
        }
    }
    
    func configure(_ tweet: Tweet, indexPath: IndexPath) {
        tweetLabel.text = tweet.text
        dateLabel.text = tweet.createdAt.tweetDateFormatted()
        retweetsCountLabel.text = "\(tweet.retweetsCount)"
        likesCountLabel.text = "\(tweet.likesCount)"
        index = indexPath.row
    }
}
