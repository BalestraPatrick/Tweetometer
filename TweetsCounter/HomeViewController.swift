//
//  ViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/19/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import NSObject_Rx
import DGElasticPullToRefresh

final class HomeViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var profileButton: ProfilePictureButton!
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>()
    let imageService = DefaultImageService.sharedImageService
    
    var viewModel = TimelineViewModel()
    var shouldPresentLogIn = false

    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        addPullToRefresh()
        setTitleViewContent(200)
        startRequests()
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
    
    deinit {
        tableView.dg_removePullToRefresh()
    }
    
    // MARK: Storyboard Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StoryboardSegue.Main.MenuPopOver.rawValue {
            let menuPopOver = segue.destinationViewController as! MenuPopOverViewController
            menuPopOver.modalPresentationStyle = UIModalPresentationStyle.Popover
            menuPopOver.popoverPresentationController!.delegate = self
            menuPopOver.view.backgroundColor = UIColor().menuDarkBlueColor()
            menuPopOver.popoverPresentationController!.backgroundColor = UIColor().menuDarkBlueColor()
        } else if segue.identifier == StoryboardSegue.Main.UserDetail.rawValue {
            let userDetail = segue.destinationViewController as? UserDetailViewController
            if let userDetail = userDetail {
                tableView
                    .rx_itemSelected
                    .map { indexPath in
                        return (indexPath, self.dataSource.itemAtIndexPath(indexPath))
                    }
                    .subscribeNext { indexPath, selectedUser in
                        userDetail.selectedUser = selectedUser
                    }
                    .addDisposableTo(rx_disposeBag)
            }
        }
    }
    
    // MARK: Data Request
    
    func startRequests() {
        do {
            // Check is a user is already logged in. If not, we present the Login View Controller
            try viewModel.session.isUserLoggedIn()

            loadTableView()

            // First request the profile information to get the profile picture URL and then request user profile picture
            viewModel.requestProfileInformation().subscribe(onNext: { [weak self] image in
                self?.viewModel.requestProfilePicture()
                    .bindNext { self?.profileButton.image = $0 }
                    .addDisposableTo(self!.rx_disposeBag)
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
    
    func loadTableView() {
        tableView.rowHeight = 75.0
        
        dataSource.configureCell = { [weak self] (table, indexPath, user) in
            guard let cell = table.dequeueReusableCellWithIdentifier(TableViewCell.UserCellIdentifier.rawValue) as? UserTableViewCell else {
                fatalError("Could not create cell with identifier \(TableViewCell.UserCellIdentifier.rawValue) in UITableView: \(table)")
            }
            cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(white: 1.0, alpha: 0.2) : UIColor(white: 1.0, alpha: 0.1)
            cell.profilePictureImageView.layer.cornerRadius = cell.profilePictureImageView.frame.size.width / 2
            cell.profilePictureImageView.layer.borderColor = UIColor.whiteColor().CGColor
            cell.profilePictureImageView.layer.borderWidth = 1.0
            cell.profilePictureImageView.layer.masksToBounds = true
            cell.screenName = user.name
            cell.username = user.screenName
            cell.numberOfFollowers = user.followersCount
            cell.numberOfFollowing = user.followingCount
            cell.numberOfTweets = user.tweets?.count ?? 0
            cell.downloadableImage = self?.imageService.imageFromURL(user.profileImageURL!) ?? Observable.empty()
            cell.index = indexPath.row
            cell.accessoryView = UIImageView(image: UIImage(named: "detail"))
            return cell
        }

        viewModel.requestTimeline(nil)
            .bindTo(tableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(rx_disposeBag)
        
        tableView
            .rx_setDelegate(self)
            .addDisposableTo(rx_disposeBag)
        
    }
    
    func addPullToRefresh() {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.whiteColor()
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] in
//            self?.loadTableView()
//            self?.viewModel.requestTimeline(nil)
            self?.tableView.reloadData()
//            self?.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor().menuDarkBlueColor())
        tableView.dg_setPullToRefreshBackgroundColor(view.backgroundColor!)
    }
    
    // MARK: IBActions
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue) {
        
    }
}