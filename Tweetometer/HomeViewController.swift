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
import IGListKit

final class HomeViewController: UIViewController {

    weak var coordinator: HomeCoordinatorDelegate!

    private let collectionView = ListCollectionView(
        frame: CGRect.zero,
        listCollectionViewLayout: ListCollectionViewLayout(stickyHeaders: true, topContentInset: 0, stretchToEdge: false)
    )

    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    private var timeline: Timeline?

    private var twitterUserTopView: UserTopBarViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        setUpTwitterUserTopView()
        requestTimeline()
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    private func setUpTwitterUserTopView() {
        twitterUserTopView = UserTopBarViewController.instantiate(with: .init(twitterSession: coordinator.twitterService, delegate: self))
        navigationItem.titleView = twitterUserTopView.view
        twitterUserTopView.view.widthAnchor.constraint(equalTo: navigationController!.view.widthAnchor).isActive = true
        twitterUserTopView.view.centerXAnchor.constraint(equalTo: navigationController!.view.centerXAnchor).isActive = true
        twitterUserTopView.view.layoutIfNeeded()
    }

    // MARK: Storyboard Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let segueIdentifier = StoryboardSegue.Main(rawValue: identifier) else { return }
        switch segueIdentifier {
        case .userDetail: break
//            guard let userDetail = segue.destination as? UserDetailViewController, let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell), let users = users else { return }
//            let selectedUser = users[indexPath.row]
//            userDetail.user = selectedUser
//            coordinator.pushDetail(userDetail)
        }
    }
    
    // MARK: Data Request

    func requestTimeline() {
        // Request tweets.
        coordinator.twitterService.getTimeline(before: nil) { result in
            switch result {
            case .success(let timeline):
                self.timeline = timeline
                DispatchQueue.main.async {
                    self.adapter.performUpdates(animated: true)
                }
            case .error(let error): self.presentError(error)
            }
        }
    }

    // MARK: UI

    private func presentError(_ error: TweetometerError) {
        switch error {
        case .rateLimitExceeded: self.presentAlert(title: "Rate Limit Exceeded ❌")
        case .noInternetConnection: self.presentAlert(title: "No Internet Connection 📡")
        default: self.presentAlert(title: error.localizedDescription)
        }
    }

    private func presentAlert(title: String) {
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
//        emptyStateLabel.isHidden = count != 0
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

extension HomeViewController: ListAdapterDataSource {

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard let timeline = timeline else { return [] }
        return timeline.tweets
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return TimelineSectionController(timeline: timeline)
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        // TODO: create empty state UIViewController
        let emptyView = UIView(frame: collectionView.bounds)
        emptyView.backgroundColor = .white
        return emptyView
    }
}
