//
//  TweetTableViewCell.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/21/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import ActiveLabel

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetLabel: ActiveLabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetsCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    
    weak var coordinator: UserDetailCoordinatorDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetLabel.textColor = UIColor.black
        dateLabel.textColor = UIColor.black
        retweetsCountLabel.textColor = UIColor.black
        likesCountLabel.textColor = UIColor.black
        
        setUpTwitterElementHandlers()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpTwitterElementHandlers() {
        tweetLabel.handleURLTap { url in
            self.coordinator.presentSafari(url)
        }
        
        tweetLabel.handleHashtagTap { hashtag in
            self.coordinator.open(hashtag: hashtag)
        }
        
        tweetLabel.handleMentionTap { mention in
            self.coordinator.open(mention: mention)
        }
    }
    
    func configure(_ tweet: Tweet, indexPath: IndexPath) {
        tweetLabel.text = tweet.text
        dateLabel.text = tweet.createdAt.tweetDateFormatted()
        retweetsCountLabel.text = "\(tweet.retweetsCount)"
        likesCountLabel.text = "\(tweet.likesCount)"
        backgroundColor = indexPath.row % 2 == 0 ? UIColor.userCellEven() : UIColor.userCellOdd()
    }
    
}
