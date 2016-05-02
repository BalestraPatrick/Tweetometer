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
        tweetLabel.textColor = UIColor.blackColor()
        dateLabel.textColor = UIColor.blackColor()
        retweetsCountLabel.textColor = UIColor.blackColor()
        likesCountLabel.textColor = UIColor.blackColor()
        
        setUpTwitterElementHandlers()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
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
    
    func configure(tweet: Tweet, indexPath: NSIndexPath) {
        tweetLabel.text = tweet.text
        dateLabel.text = tweet.createdAt.tweetDateFormatted()
        retweetsCountLabel.text = "\(tweet.retweetsCount)"
        likesCountLabel.text = "\(tweet.likesCount)"
        backgroundColor = indexPath.row % 2 == 0 ? UIColor.whiteColor() : UIColor(white: 0.97, alpha: 1.0)
    }
    
}
