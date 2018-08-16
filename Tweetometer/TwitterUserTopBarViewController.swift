//
//  TwitterUserTopBarViewController.swift
//  Tweetometer
//
//  Created by Patrick Balestra on 8/15/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import UIKit
import TweetometerKit

class TwitterUserTopBarViewController: UIViewController {

    var twitterService: TwitterSession!

    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var yourTimelineLabel: UILabel!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    private func loadData() {
        twitterService.loadUserData { result in
            switch result {
            case .success(let user):
                self.profileImageView?.kf.setImage(with: URL(string: user.profileImageURL)!)
            case .error:
                self.profileImageView?.image = Asset.placeholder.image
            }
        }
        profileImageView?.kf.indicatorType = .activity
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.layer.masksToBounds = true
    }

    @IBAction private func openSettings(_ sender: Any) {

    }
}
