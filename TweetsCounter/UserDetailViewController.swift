//
//  UserDetailViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/6/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import NSObject_Rx

final class UserDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    let viewModel = UserViewModel()
    let linkOpener = LinkOpener()
    
    var user: User?
    weak var delegate: UserDetailViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        
        guard let user = user else { return }
        print(user.description)
        setTitleViewContent(user.name, screenName: user.screenName)
        viewModel.user = user
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return user?.tweets?.count ?? 0
        default: return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, _):
            let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCell.UserDetailsCellIdentifier.rawValue, forIndexPath: indexPath) as! UserDetailsTableViewCell
            if let user = user {
                cell.configure(user)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCell.TweetCellIdentifier.rawValue, forIndexPath: indexPath) as! TweetTableViewCell
            if let user = user, let tweets = user.tweets {
                let tweet = tweets[indexPath.row]
                cell.configure(tweet, indexPath: indexPath)
                cell.delegate = delegate
            }
            return cell
        }
    }
    
    // MARK: IBActions
    
    @IBAction func openIn(sender: UIBarButtonItem) {
        if let user = user {
            delegate.openUser(user.screenName)
        }
    }
}
