//
//  UserTableViewCell.swift
//  
//
//  Created by Patrick Balestra on 1/30/16.
//
//

import UIKit
import TweetometerKit

final class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePictureImageView: ProfilePictureImageView!
    @IBOutlet fileprivate weak var screenNameLabel: UILabel!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var followersLabel: UILabel!
    @IBOutlet fileprivate weak var followingLabel: UILabel!
    @IBOutlet fileprivate weak var numberOfTweetsLabel: UILabel!

    var index = 0 {
        didSet {
            backgroundColor = index % 2 == 0 ? UIColor.userCellEven() : UIColor.userCellOdd()
        }
    }
    
    var screenName: String = "" {
        didSet {
            screenNameLabel.text = screenName
        }
    }
    
    var username: String = "" {
        didSet {
            usernameLabel.text = "@\(username)"
        }
    }
    
    var numberOfFollowers: Int = 0 {
        didSet {
            followersLabel.attributedText = NSAttributedString.followersAttributes(with: numberOfFollowers)
        }
    }
    
    var numberOfFollowing: Int = 0 {
        didSet {
            followingLabel.attributedText = NSAttributedString.followingAttributes(with: numberOfFollowing)
        }
    }
    
    var numberOfTweets: Int = 0 {
        didSet {
            numberOfTweetsLabel.attributedText = NSAttributedString.tweetsAttributes(with: numberOfTweets)
        }
    }

    // MARK: UITableViewCell Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()

        profilePictureImageView.image = UIImage(asset: .placeholder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        accessoryView = UIImageView(image: UIImage(named: "detail"))
        accessibilityElements = [profilePictureImageView, screenNameLabel, usernameLabel, followersLabel, followingLabel, numberOfTweetsLabel]
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            backgroundColor = UIColor.userCellSelected()
        } else {
            backgroundColor = index % 2 == 0 ? UIColor.userCellEven() : UIColor.userCellOdd()
        }
    }
    
    func configure(_ user: User, indexPath: IndexPath) {
        screenName = user.name
        username = user.screenName
        numberOfFollowers = user.followersCount
        numberOfFollowing = user.followingCount
        numberOfTweets = user.tweets.count
        index = indexPath.row
        if let stringURL = user.profileImageURL, let URL = URL(string: stringURL) {
            profilePictureImageView.af_setImage(withURL: URL, placeholderImage: UIImage(asset: .placeholder))
        }
    }
}
