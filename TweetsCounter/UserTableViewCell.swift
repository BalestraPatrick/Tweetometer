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

final class UserTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var profilePictureImageView: UIImageView!
    @IBOutlet private weak var screenNameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var followersLabel: UILabel!
    @IBOutlet private weak var followingLabel: UILabel!
    @IBOutlet private weak var numberOfTweetsLabel: UILabel!
    
    var disposeBag = DisposeBag()
    var downloadableImage: Observable<DownloadableImage>? {
        didSet {
            self.downloadableImage?
                .asDriver(onErrorJustReturn: DownloadableImage.OfflinePlaceholder)
                .drive(profilePictureImageView.rxex_downloadableImageAnimated(kCATransitionFade))
                .addDisposableTo(disposeBag)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
