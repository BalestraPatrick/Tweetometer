//
//  UserDetailViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/6/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import TweetometerKit

final class UserDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    let linkOpener = LinkOpener()
    
    var element: TwitterTimelineElement?
    weak var coordinator: UserDetailCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()

        guard let element = element else { return }
        setTitleViewContent(element.user.name, screenName: element.user.screenName)
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return element?.tweets.count ?? 0
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.UserDetailsCellIdentifier.rawValue, for: indexPath) as! UserDetailsTableViewCell
            if let element = element {
                cell.configure(element.user, coordinator: coordinator)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.TweetCellIdentifier.rawValue, for: indexPath) as! TweetTableViewCell
            if let element = element {
                let tweet = element.tweets[indexPath.row]
                cell.configure(tweet, indexPath: indexPath, coordinator: coordinator)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Open tweet in user's preferred client
        guard indexPath.section != 0 else { return }
        if let tweetId = element?.tweets[indexPath.row].idStr, let userId = element?.user.screenName {
            coordinator.open(tweet: tweetId, user: userId)
        }
    }

    // MARK: IBActions
    
    @IBAction func openIn(_ sender: UIBarButtonItem) {
        if let element = element {
            coordinator.open(user: element.user.screenName)
        }
    }
}
