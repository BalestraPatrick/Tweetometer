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
            backgroundColor = index % 2 == 0 ? UIColor.userCellEven() : UIColor.userCellOdd()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        tweetLabel.textColor = UIColor.black
        dateLabel.textColor = UIColor.black
        retweetsCountLabel.textColor = UIColor.black
        likesCountLabel.textColor = UIColor.black
        setUpTwitterElementHandlers()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            backgroundColor = UIColor.userCellSelected()
        } else {
            backgroundColor = index % 2 == 0 ? UIColor.userCellEven() : UIColor.userCellOdd()
        }
    }

    func setUpTwitterElementHandlers() {
        tweetLabel.handleURLTap { url in
            self.coordinator.presentSafari(url)
        }
        
        tweetLabel.handleHashtagTap { hashtag in
            self.coordinator.open(hashtag: hashtag)
        }
        
        tweetLabel.handleMentionTap { mention in
            self.coordinator.open(user: mention)
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
