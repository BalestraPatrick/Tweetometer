//
//  TweetTableViewCell.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/21/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        tweetLabel.textColor = UIColor.whiteColor()
        dateLabel.textColor = UIColor.whiteColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
