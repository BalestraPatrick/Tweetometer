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
    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 2)
    private var timelineController: TimelineModelController?
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
    
    // MARK: Data Request

    func requestTimeline() {
        // Request tweets.
        coordinator.twitterService.getTimeline(before: nil) { result in
            switch result {
            case .success(let timelineController):
                self.timelineController = timelineController
                DispatchQueue.main.async {
                    self.adapter.performUpdates(animated: true)
                }
            case .error(let error):
                DispatchQueue.main.async {
                    self.presentError(error)
                }
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
        guard let timelineController = timelineController else { return [] }
        return timelineController.usersTimeline()
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? TimelineUserCollectionViewCell, let user = item as? TwitterTimelineElement else { return }
            cell.configure(with: user)
        }
        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
            guard let context = context else { return .zero }
            return CGSize(width: context.containerSize.width, height: 80)
        }
        let sectionController = ListSingleSectionController(nibName: "TimelineUserCollectionViewCell",
                                                            bundle: Bundle.main,
                                                            configureBlock: configureBlock,
                                                            sizeBlock: sizeBlock)
        sectionController.selectionDelegate = self
        return sectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        // TODO: cache this view
        // TODO: create empty state UIViewController
//        let emptyView = UIView(frame: collectionView.bounds)
//        emptyView.backgroundColor = .white
//        return emptyView
        return nil
    }
}

extension HomeViewController: ListSingleSectionControllerDelegate {

    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        guard let element = object as? TwitterTimelineElement else { return }
        // TODO: move scene creation to coordinator
        let detailViewController = StoryboardScene.Main.userDetail.instantiate()
        detailViewController.element = element
        navigationController?.pushViewController(detailViewController, animated: true)
//        coordinator.pushDetail(detailViewController)
    }
}
