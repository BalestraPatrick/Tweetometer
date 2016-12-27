//
//  ViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/19/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import TweetometerKit
import RealmSwift
import PullToRefresh
import Whisper

enum TableViewStatus {
    case refreshing
    case notRefreshing
}

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var profilePictureItem: ProfilePictureButtonItem!
    @IBOutlet weak var emptyStateLabel: UILabel!

    fileprivate lazy var session = TwitterSession.shared
    fileprivate var notificationToken: NotificationToken?
    fileprivate var refresher: TweetometerPullToRefresh!
    private let activityManager = NetworkingActivityIndicatorManager()

    var users: Results<User>?
    weak var coordinator: HomeCoordinatorDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        tableView.rowHeight = 75.0
        refresher = TweetometerPullToRefresh()
        tableView.addPullToRefresh(refresher) {
            self.refreshTimeline()
        }

        let realm = DataManager.realm()
        users = realm.objects(User.self).sorted(byProperty: "tweetsCount", ascending: false)
        notificationToken = users?.addNotificationBlock(tableView.applyChanges)

        // Check if a user is logged in
        if session.isUserLoggedIn() == false {
            coordinator.presentLogin()
        } else {
            // Start requests
            requestProfilePicture()
            refreshTimeline()
        }
    }

    deinit {
        notificationToken?.stop()
        tableView.removePullToRefresh(refresher)
    }

    // MARK: Storyboard Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let segueIdentifier = StoryboardSegue.Main(rawValue: identifier) else { return }

        switch segueIdentifier {
        case .menuPopOver:
            guard let menuPopOver = segue.destination as? MenuPopOverViewController else { return }
            menuPopOver.modalPresentationStyle = .popover
            menuPopOver.view.backgroundColor = .menuDarkBlue()
            menuPopOver.popoverPresentationController!.delegate = self
            menuPopOver.popoverPresentationController!.backgroundColor = .menuDarkBlue()
            coordinator.presentMenu(menuPopOver)
        case .userDetail:
            guard let userDetail = segue.destination as? UserDetailViewController, let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell), let users = users else { return }
            let selectedUser = users[indexPath.row]
            userDetail.user = selectedUser
            coordinator.pushDetail(userDetail)
        }
    }
    
    // MARK: Data Request

    func refreshTimeline() {
        setRefreshUI(to: .refreshing)
    }

    func setRefreshUI(to status: TableViewStatus) {
        if case .refreshing = status {
            requestTimeline()
            tableView.startRefreshing(at: .top)
//            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        } else {
            tableView.endRefreshing(at: .top)
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

    func requestProfilePicture() {
        // Request profile picture
        session.getProfilePictureURL { [weak self] url in
            guard let url = url, let weakSelf = self else { return }
            weakSelf.set(screenName: weakSelf.session.loggedUserScreenName())
            weakSelf.profilePictureItem.imageView.af_setImage(withURL: url, placeholderImage: UIImage(asset: .placeholder))
        }
    }

    func requestTimeline() {
        // Request tweets.
        session.getTimeline(before: nil) { error in
            if let error = error {
                switch error {
                case .rateLimitExceeded:
                    self.presentAlert(title: "Rate Limit Exceeded ❌")
                case .noInternetConnection:
                    self.presentAlert(title: "No Internet Connection 📡")
                default:
                    self.presentAlert(title: error.localizedDescription)
                    break
                }
            }
        }
    }

    // MARK: UI

    func presentAlert(title: String) {
        guard let navigationController = navigationController else { return print("No navigation controller in this view hierarchy") }
        setRefreshUI(to: .notRefreshing)
        Whisper.Config.modifyInset = false
        let whisperMessage = Message(title: title, textColor: .white, backgroundColor: .backgroundBlue(), images: nil)
        Whisper.show(whisper: whisperMessage, to: navigationController, action: .show)
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
        // TODO: move this code somewhere else
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//        endRefreshing(at: Position.top)
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
