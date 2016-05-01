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

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var profileButton: ProfilePictureButton!
    
    let viewModel = TimelineViewModel()
    let settingsManager = SettingsManager.sharedManager
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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if shouldPresentLogIn {
            let logInViewController = StoryboardScene.Main.twitterLoginViewController()
            logInViewController.homeViewController = self
            presentViewController(logInViewController, animated: true, completion: {
                self.shouldPresentLogIn = false
            })
        }
    }
    
    // MARK: Storyboard Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StoryboardSegue.Main.MenuPopOver.rawValue {
            let menuPopOver = segue.destinationViewController as! MenuPopOverViewController
            menuPopOver.modalPresentationStyle = UIModalPresentationStyle.Popover
            menuPopOver.popoverPresentationController!.delegate = self
            menuPopOver.view.backgroundColor = UIColor().menuDarkBlueColor()
            menuPopOver.popoverPresentationController!.backgroundColor = UIColor().menuDarkBlueColor()
            menuPopOver.homeViewController = self
        } else if segue.identifier == StoryboardSegue.Main.UserDetail.rawValue {
            if let userDetail = segue.destinationViewController as? UserDetailViewController, let cell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(cell) {
                let selectedUser = dataSource[indexPath.row]
                userDetail.selectedUser = selectedUser
                delegate.pushDetail(userDetail)
            }
        }
    }
    
    // MARK: Data Request
    
    func startRequests() {
        do {
            // Check is a user is already logged in. If not, we present the Login View Controller
            try viewModel.session.isUserLoggedIn()
            
            // First request the profile information to get the profile picture URL and then request user profile picture
            viewModel.requestProfileInformation().subscribe(onNext: { [weak self] image in
                self?.viewModel.requestProfilePicture()
                    .bindNext { self?.profileButton.image = $0 }
                    .addDisposableTo(self!.rx_disposeBag)
                }, onError: { error in
                    ErrorDisplayer().display(error)
                }, onCompleted: nil, onDisposed: nil)
                .addDisposableTo(rx_disposeBag)
            
            viewModel.requestTimeline(nil).subscribe(onNext: { users in
                self.reloadTableViewWithDataSource(users)
                }, onError: { error in
                    ErrorDisplayer().display(error)
                }, onCompleted: nil, onDisposed: nil)
                .addDisposableTo(rx_disposeBag)
        } catch {
            switch error {
            case TwitterRequestError.NotAuthenticated:
                shouldPresentLogIn = true
            default:
                print("Failed to request profile information with error: \(error)")
            }
        }
    }
    
    func reloadTableViewWithDataSource(users: [User]) {
        dataSource = users
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCell.UserCellIdentifier.rawValue) as? UserTableViewCell else {
            fatalError("Could not create cell with identifier \(TableViewCell.UserCellIdentifier.rawValue) in UITableView: \(tableView)")
        }
        let user = dataSource[indexPath.row]
        cell.configure(user, indexPath: indexPath)
        return cell
    }
}
