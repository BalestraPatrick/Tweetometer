//
//  UserTopBarViewController.swift
//  Tweetometer
//
//  Created by Patrick Balestra on 8/15/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import UIKit
import TweetometerKit

protocol UserTopBarDelegate {
    func openSettings(sender: UIView)
}

class UserTopBarViewController: UIViewController {

    struct Dependencies {
        let twitterSession: TwitterSession
        let delegate: UserTopBarDelegate
    }

    private var dependencies: Dependencies!

    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var yourTimelineLabel: UILabel!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet var settingsButton: UIButton!

    static func instantiate(with dependencies: Dependencies) -> UserTopBarViewController {
        let this = StoryboardScene.UserTopBar.initialScene.instantiate()
        this.dependencies = dependencies
        return this
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    private func loadData() {
        dependencies.twitterSession.loadUserData { result in
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

    @IBAction func openSettings(_ sender: UIView) {
        dependencies.delegate.openSettings(sender: sender)
    }
}
