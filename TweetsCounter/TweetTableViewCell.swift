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
    
    weak var delegate: UserDetailViewControllerDelegate!
    
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
            self.delegate.presentSafari(url)
        }
        
        tweetLabel.handleHashtagTap { hashtag in
            
        }
        
        tweetLabel.handleMentionTap { mention in
            
        }
    }
    
    func configure(_ tweet: Tweet, indexPath: IndexPath) {
        tweetLabel.text = tweet.text
        dateLabel.text = tweet.createdAt.tweetDateFormatted()
        retweetsCountLabel.text = "\(tweet.retweetsCount)"
        likesCountLabel.text = "\(tweet.likesCount)"
        backgroundColor = indexPath.row % 2 == 0 ? UIColor.white : UIColor(white: 0.97, alpha: 1.0)
    }
    
}
