//
//  ViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/19/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import PullToRefresh
import RealmSwift

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var profilePictureItem: ProfilePictureButtonItem!
    @IBOutlet weak var emptyStateLabel: UILabel!

    lazy var session = TwitterSession()
    var notificationToken: NotificationToken?
//    let settingsManager = SettingsManager.sharedManager
    let refresher = PullToRefresh()

    var users: Results<User>?
    var dataSource = [User]() {
        didSet {
//            emptyStateLabel.isHidden = dataSource.count != 0
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    weak var coordinator: HomeCoordinatorDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
//        settingsManager.delegate = self
        tableView.rowHeight = 75.0

        tableView.addPullToRefresh(refresher, action: {
            self.requestTimeline()
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let realm = try! Realm()
        users = realm.objects(User.self).sorted(byProperty: "tweetsCount")
        notificationToken = users?.addNotificationBlock(tableView.applyChanges)

        // Check if a user is logged in
        if session.isUserLoggedIn() == false {
            coordinator.presentLogin()
        } else {
            // Start requests
            requestProfilePicture()
            requestTimeline()
        }
    }

    deinit {
        notificationToken?.stop()
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
            if let userDetail = segue.destination as? UserDetailViewController, let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell), let users = users {
                let selectedUser = users[indexPath.row]
                userDetail.user = selectedUser
                coordinator.pushDetail(userDetail)
            }
        }
    }
    
    // MARK: Data Request

    func requestProfilePicture() {
        // Request profile picture
        session.getProfilePicture {  url in
            guard let url = url else { return }
            self.profilePictureItem.imageView.af_setImage(withURL: url, placeholderImage: UIImage(asset: .placeholder))
        }
    }

    func requestTimeline() {
        // Request tweets.
        session.getTimeline(before: nil) { error in
            if let error = error {
                switch error {
                case .rateLimitExceeded:
                    self.presentAlert(title: "Rate Limit Exceeded ❌")
                default:
                    break
                }
            }
        }
    }

    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let users = users, let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.UserCellIdentifier.rawValue) as? UserTableViewCell else {
            fatalError("Could not create cell with identifier \(TableViewCell.UserCellIdentifier.rawValue) in UITableView: \(tableView)")
        }
        let user = users[indexPath.row]
        cell.configure(user, indexPath: indexPath)
        return cell
    }
}

extension UITableView {

    func applyChanges<T>(changes: RealmCollectionChange<T>) {
        endRefreshing(at: Position.top)
        switch changes {
        case .initial: reloadData()
        case .update(_, let deletions, let insertions, let updates):
            let fromRow = { IndexPath(row: $0, section: 0) }
            beginUpdates()
            insertRows(at: insertions.map(fromRow), with: .automatic)
            reloadRows(at: updates.map(fromRow), with: .none)
            deleteRows(at: deletions.map(fromRow), with: .automatic)
            endUpdates()
        default: break
        }
    }
}

extension UIViewController {

    func presentAlert(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
