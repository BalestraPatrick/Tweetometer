//
//  UserTableViewCell.swift
//  
//
//  Created by Patrick Balestra on 1/30/16.
//
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePictureImageView: ProfilePictureImageView!
    @IBOutlet fileprivate weak var screenNameLabel: UILabel!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var followersLabel: UILabel!
    @IBOutlet fileprivate weak var followingLabel: UILabel!
    @IBOutlet fileprivate weak var numberOfTweetsLabel: UILabel!

    var index = 0 {
        didSet {
            backgroundColor = index % 2 == 0 ? UIColor(white: 1.0, alpha: 0.2) : UIColor(white: 1.0, alpha: 0.1)
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
            let numberAttributes = [NSForegroundColorAttributeName : UIColor.white,
                                    NSFontAttributeName : UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)]
            let attributedString = NSMutableAttributedString(string: String(numberOfFollowers), attributes: numberAttributes)
            let followersAttributes = [NSForegroundColorAttributeName : UIColor.white,
                                       NSFontAttributeName : UIFont.systemFont(ofSize: 11, weight: UIFontWeightThin)]
            let followersWord = NSAttributedString(string: " Followers", attributes: followersAttributes)
            attributedString.append(followersWord)
            followersLabel.attributedText = attributedString
        }
    }
    
    var numberOfFollowing: Int = 0 {
        didSet {
            let numberAttributes = [NSForegroundColorAttributeName : UIColor.white,
                                    NSFontAttributeName : UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)]
            let attributedString = NSMutableAttributedString(string: String(numberOfFollowing), attributes: numberAttributes)
            let followersAttributes = [NSForegroundColorAttributeName : UIColor.white,
                                       NSFontAttributeName : UIFont.systemFont(ofSize: 11, weight: UIFontWeightThin)]
            let followersWord = NSAttributedString(string: " Following", attributes: followersAttributes)
            attributedString.append(followersWord)
            followingLabel.attributedText = attributedString
        }
    }
    
    var numberOfTweets: Int = 0 {
        didSet {
            let numberAttributes = [NSForegroundColorAttributeName : UIColor.white,
                                    NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)]
            let attributedString = NSMutableAttributedString(string: String(numberOfTweets), attributes: numberAttributes)
            let followersAttributes = [NSForegroundColorAttributeName : UIColor.white,
                                       NSFontAttributeName : UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)]
            let word = numberOfTweets > 1 ? " Tweets" : " Tweet"
            let followersWord = NSAttributedString(string: word, attributes: followersAttributes)
            attributedString.append(followersWord)
            numberOfTweetsLabel.attributedText = attributedString
        }
    }
    
//    var downloadableImage: Observable<DownloadableImage>? {
//        didSet {
//            self.downloadableImage?
//                .asDriver(onErrorJustReturn: DownloadableImage.offlinePlaceholder)
//                .drive(profilePictureImageView.rxex_downloadableImageAnimated(kCATransitionFade))
//                .addDisposableTo(rx_disposeBag)
//        }
//    }

    // MARK: UITableViewCell Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        accessoryView = UIImageView(image: UIImage(named: "detail"))
        accessibilityElements = [profilePictureImageView, screenNameLabel, usernameLabel, followersLabel, followingLabel, numberOfTweetsLabel]
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            self.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        } else {
            self.backgroundColor = index % 2 == 0 ? UIColor(white: 1.0, alpha: 0.2) : UIColor(white: 1.0, alpha: 0.1)
        }
    }
    
    func configure(_ user: User, indexPath: IndexPath) {
        screenName = user.name
        username = user.screenName
        numberOfFollowers = user.followersCount
        numberOfFollowing = user.followingCount
        numberOfTweets = user.tweets?.count ?? 0
//        downloadableImage = imageService.imageFromURL(user.profileImageURL! as NSURL) ?? Observable.empty()
        index = indexPath.row
    }
    
}
