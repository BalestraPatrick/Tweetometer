//
//  ViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/19/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import PullToRefresh

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var profilePictureItem: ProfilePictureButtonItem!

    lazy var session = TwitterSession()
    let settingsManager = SettingsManager.sharedManager
    let refresher = PullToRefresh()
    
    var dataSource = [User]()
    weak var coordinator: HomeCoordinatorDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        settingsManager.delegate = self
        tableView.rowHeight = 75.0

        tableView.addPullToRefresh(refresher, action: {
            self.requestTimeline()
        })
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Check if a user is logged in
        if session.isUserLoggedIn() == false {
            coordinator.presentLogin()
        } else {
            // Request profile picture
            session.getProfilePicture(completion: { [weak self] url in
                self?.profilePictureItem.imageView.af_setImage(withURL: url, placeholderImage: UIImage(asset: .placeholder))
            })
        }
    }

    // MARK: Storyboard Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryboardSegue.Main.MenuPopOver.rawValue {
            let menuPopOver = segue.destination as! MenuPopOverViewController
            menuPopOver.modalPresentationStyle = UIModalPresentationStyle.popover
            menuPopOver.popoverPresentationController!.delegate = self
            menuPopOver.view.backgroundColor = UIColor().menuDarkBlueColor()
            menuPopOver.popoverPresentationController!.backgroundColor = UIColor().menuDarkBlueColor()
            menuPopOver.homeViewController = self
        } else if segue.identifier == StoryboardSegue.Main.UserDetail.rawValue {
            if let userDetail = segue.destination as? UserDetailViewController, let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                let selectedUser = dataSource[indexPath.row]
                userDetail.user = selectedUser
                coordinator.pushDetail(userDetail)
            }
        }
    }
    
    // MARK: Data Request

    func requestTimeline() {
        tableView.startRefreshing(at: Position.top)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func reloadTableViewWithDataSource(_ users: [User]) {
        dataSource = users
        tableView.reloadData()
        tableView.endRefreshing(at: Position.top)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.UserCellIdentifier.rawValue) as? UserTableViewCell else {
            fatalError("Could not create cell with identifier \(TableViewCell.UserCellIdentifier.rawValue) in UITableView: \(tableView)")
        }
        let user = dataSource[indexPath.row]
        cell.configure(user, indexPath: indexPath)
        return cell
    }
}
