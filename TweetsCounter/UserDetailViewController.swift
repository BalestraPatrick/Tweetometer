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

final class UserDetailViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    let viewModel = UserViewModel()
    let dataSource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, Tweet>>()
    let linkOpener = LinkOpener()

    var selectedUser: User?
    
    weak var delegate: UserDetailViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        
        guard let user = selectedUser else { return }
        setTitleViewContent(user.name, screenName: user.screenName)
        viewModel.user = user
        
        loadTableView()
    }
    
    func loadTableView() {
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        dataSource.configureCell = { (table, indexPath, tweet) in
            guard let cell = table.dequeueReusableCellWithIdentifier(TableViewCell.TweetCellIdentifier.rawValue) as? TweetTableViewCell else {
                fatalError("Could not create cell with identifier \(TableViewCell.UserCellIdentifier.rawValue) in UITableView: \(table)")
            }
            cell.delegate = self.delegate
            cell.tweetLabel.text = tweet.value.text
            cell.dateLabel.text = tweet.value.createdAt.tweetDateFormatted()
            return cell
        }
        
        viewModel.tweets()
            .bindTo(tableView.rx_itemsAnimatedWithDataSource(dataSource))
            .addDisposableTo(rx_disposeBag)

        tableView
            .rx_setDelegate(self)
            .addDisposableTo(rx_disposeBag)
    }
    
    @IBAction func openIn(sender: UIBarButtonItem) {
        guard let user = selectedUser else {
            return
        }
        linkOpener.openUser(user)
    }
}
