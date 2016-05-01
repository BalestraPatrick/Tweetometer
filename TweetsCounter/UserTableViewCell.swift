//
//  UserTableViewCell.swift
//  
//
//  Created by Patrick Balestra on 1/30/16.
//
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

final class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet private weak var screenNameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var followersLabel: UILabel!
    @IBOutlet private weak var followingLabel: UILabel!
    @IBOutlet private weak var numberOfTweetsLabel: UILabel!
    
    let imageService = DefaultImageService.sharedImageService
    
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
            let numberAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(),
                                    NSFontAttributeName : UIFont.systemFontOfSize(15, weight: UIFontWeightLight)]
            let attributedString = NSMutableAttributedString(string: String(numberOfFollowers), attributes: numberAttributes)
            let followersAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(),
                                       NSFontAttributeName : UIFont.systemFontOfSize(11, weight: UIFontWeightThin)]
            let followersWord = NSAttributedString(string: " Followers", attributes: followersAttributes)
            attributedString.appendAttributedString(followersWord)
            followersLabel.attributedText = attributedString
        }
    }
    
    var numberOfFollowing: Int = 0 {
        didSet {
            let numberAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(),
                                    NSFontAttributeName : UIFont.systemFontOfSize(15, weight: UIFontWeightLight)]
            let attributedString = NSMutableAttributedString(string: String(numberOfFollowing), attributes: numberAttributes)
            let followersAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(),
                                       NSFontAttributeName : UIFont.systemFontOfSize(11, weight: UIFontWeightThin)]
            let followersWord = NSAttributedString(string: " Following", attributes: followersAttributes)
            attributedString.appendAttributedString(followersWord)
            followingLabel.attributedText = attributedString
        }
    }
    
    var numberOfTweets: Int = 0 {
        didSet {
            let numberAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(),
                                    NSFontAttributeName : UIFont.systemFontOfSize(20, weight: UIFontWeightLight)]
            let attributedString = NSMutableAttributedString(string: String(numberOfTweets), attributes: numberAttributes)
            let followersAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(),
                                       NSFontAttributeName : UIFont.systemFontOfSize(15, weight: UIFontWeightThin)]
            let word = numberOfTweets > 1 ? " Tweets" : " Tweet"
            let followersWord = NSAttributedString(string: word, attributes: followersAttributes)
            attributedString.appendAttributedString(followersWord)
            numberOfTweetsLabel.attributedText = attributedString
        }
    }
    
    var downloadableImage: Observable<DownloadableImage>? {
        didSet {
            self.downloadableImage?
                .asDriver(onErrorJustReturn: DownloadableImage.OfflinePlaceholder)
                .drive(profilePictureImageView.rxex_downloadableImageAnimated(kCATransitionFade))
                .addDisposableTo(rx_disposeBag)
        }
    }
    
    // MARK: UITableViewCell Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.size.width / 2
        profilePictureImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profilePictureImageView.layer.borderWidth = 1.0
        profilePictureImageView.layer.masksToBounds = true
        
        accessoryView = UIImageView(image: UIImage(named: "detail"))
        accessibilityElements = [profilePictureImageView, screenNameLabel, usernameLabel, followersLabel, followingLabel, numberOfTweetsLabel]
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            self.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        } else {
            self.backgroundColor = index % 2 == 0 ? UIColor(white: 1.0, alpha: 0.2) : UIColor(white: 1.0, alpha: 0.1)
        }
    }
    
    func configure(user: User, indexPath: NSIndexPath) {
        screenName = user.name
        username = user.screenName
        numberOfFollowers = user.followersCount
        numberOfFollowing = user.followingCount
        numberOfTweets = user.tweets?.count ?? 0
        downloadableImage = imageService.imageFromURL(user.profileImageURL!) ?? Observable.empty()
        index = indexPath.row
    }
    
}
