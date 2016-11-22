//
//  ViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/19/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import RxSwift
import NSObject_Rx
import PullToRefresh

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var profileButton: ProfilePictureButton!
    
    let viewModel = TimelineViewModel()
    let settingsManager = SettingsManager.sharedManager
    let refresher = PullToRefresh()
    
    var dataSource = [User]()
    var shouldPresentLogIn = false
    weak var delegate: HomeViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        startRequests()
        setTitleViewContent(settingsManager.numberOfAnalyzedTweets)
        settingsManager.delegate = self
        tableView.rowHeight = 75.0
        
        tableView.addPullToRefresh(refresher, action: {
            self.requestTimeline()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if shouldPresentLogIn {
            let logInViewController = StoryboardScene.Main.twitterLoginViewController()
            logInViewController.homeViewController = self
            present(logInViewController, animated: true, completion: {
                self.shouldPresentLogIn = false
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
                delegate.pushDetail(userDetail)
            }
        }
    }
    
    // MARK: Data Request
    
    func startRequests() {
        do {
            // Check is a user is already logged in. If not, we present the Login View Controller
            _ = try viewModel.session.isUserLoggedIn()
            
            // First request the profile information to get the profile picture URL and then request user profile picture
            viewModel.requestProfileInformation().subscribe(onNext: { [weak self] image in
                self?.viewModel.requestProfilePicture()
                    .bindNext { self?.profileButton.image = $0 }
                    .addDisposableTo(self!.rx_disposeBag)
                }, onError: { error in
                    ErrorDisplayer().display(error)
                }, onCompleted: nil, onDisposed: nil)
                .addDisposableTo(rx_disposeBag)
            
            requestTimeline()
        } catch {
            switch error {
            case TwitterRequestError.notAuthenticated:
                shouldPresentLogIn = true
            default:
                print("Failed to request profile information with error: \(error)")
            }
        }
    }
    
    func requestTimeline() {
        tableView.startRefreshing(at: Position.top)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        viewModel.requestTimeline(nil).subscribe(onNext: { users in
            self.reloadTableViewWithDataSource(users)
            }, onError: { error in
                ErrorDisplayer().display(error)
            }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(rx_disposeBag)
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
