//
//  ViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/19/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import TweetometerKit
import Whisper
import Kingfisher

enum TableViewStatus {
    case refreshing
    case notRefreshing
}

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var profilePictureItem: UIButton!
    @IBOutlet weak var emptyStateLabel: UILabel!

    weak var coordinator: HomeCoordinatorDelegate!
    var twitterUserTopView: UserTopBarViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        tableView.rowHeight = 75.0
        setUpTwitterUserTopView()
    }

    private func setUpTwitterUserTopView() {
        twitterUserTopView = UserTopBarViewController.instantiate(with: .init(twitterSession: coordinator.twitterService, delegate: self))
        navigationItem.titleView = twitterUserTopView.view
        twitterUserTopView.view.widthAnchor.constraint(equalTo: navigationController!.view.widthAnchor).isActive = true
        twitterUserTopView.view.centerXAnchor.constraint(equalTo: navigationController!.view.centerXAnchor).isActive = true
        twitterUserTopView.view.layoutIfNeeded()
    }

    func refresh() {
        tableView.reloadData()
    }

    // MARK: Storyboard Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let segueIdentifier = StoryboardSegue.Main(rawValue: identifier) else { return }

        switch segueIdentifier {
//        case .menuPopOver:
//            guard let menuPopOver = segue.destination as? MenuPopOverViewController else { return }
//            menuPopOver.modalPresentationStyle = .popover
//            menuPopOver.view.backgroundColor = .menuDarkBlue()
//            menuPopOver.popoverPresentationController!.delegate = self
//            menuPopOver.popoverPresentationController!.backgroundColor = .menuDarkBlue()
//            coordinator.presentMenu(menuPopOver)
        case .userDetail: break
//            guard let userDetail = segue.destination as? UserDetailViewController, let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell), let users = users else { return }
//            let selectedUser = users[indexPath.row]
//            userDetail.user = selectedUser
//            coordinator.pushDetail(userDetail)
        }
    }
    
    // MARK: Data Request

    func refreshTimeline() {
//        setRefreshUI(to: .refreshing)
    }

//    func setRefreshUI(to status: TableViewStatus) {
//        if case .refreshing = status {
//            requestTimeline()
//            tableView.startRefreshing(at: .top)
//        } else {
//            tableView.endRefreshing(at: .top)
//            print("Last update: \(session.lastUpdate.updateString())")
////            refresher.refresherData = RefresherData(lastUpdate: session.lastUpdate.updateString(), numberOfTweets: DataManager.realm().objects(Tweet.self).count)
//        }
//    }

//    func requestTimeline() {
//        // Request tweets.
//        session.getTimeline(before: nil) { error in
//            if let error = error {
//                switch error {
//                case .rateLimitExceeded:
//                    self.presentAlert(title: "Rate Limit Exceeded ❌")
//                case .noInternetConnection:
//                    self.presentAlert(title: "No Internet Connection 📡")
//                default:
//                    self.presentAlert(title: error.localizedDescription)
//                    break
//                }
//            } else {
//                self.session.lastUpdate = Date()
//            }
//            self.setRefreshUI(to: .notRefreshing)
//        }
//    }

    // MARK: UI

    func presentAlert(title: String) {
        guard let navigationController = navigationController else { return print("No navigation controller in this view hierarchy. Skipping the presentation.") }
        Whisper.Config.modifyInset = false
        let whisperMessage = Message(title: title, textColor: .white, backgroundColor: .backgroundBlue(), images: nil)
        Whisper.show(whisper: whisperMessage, to: navigationController, action: .show)
    }

    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = /*users?.count ??*/ 0
        emptyStateLabel.isHidden = count != 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.UserCellIdentifier.rawValue) as? UserTableViewCell else {
            fatalError("Could not create cell with identifier \(TableViewCell.UserCellIdentifier.rawValue) in UITableView: \(tableView)")
        }
//        let user = users[indexPath.row]
//        cell.configure(user, indexPath: indexPath)
        return cell
    }
}


extension HomeViewController: UserTopBarDelegate {

    func openSettings(sender: UIView) {
        let menuPopOver = StoryboardScene.Main.menuPopOver.instantiate()
        menuPopOver.modalPresentationStyle = .popover
        menuPopOver.view.backgroundColor = .menuDarkBlue()
        menuPopOver.popoverPresentationController?.delegate = self
        menuPopOver.popoverPresentationController?.backgroundColor = .menuDarkBlue()
        menuPopOver.popoverPresentationController?.sourceView = sender
        menuPopOver.popoverPresentationController?.sourceRect = CGRect(x: 13, y: sender.bounds.height, width: 0, height: 0)
        coordinator.presentMenu(menuPopOver)
    }
}
