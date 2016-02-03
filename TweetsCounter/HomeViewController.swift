//
//  ViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/19/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class HomeViewController: UIViewController, UITableViewDelegate {
    
    let disposeBag = DisposeBag()
    let imageService = DefaultImageService.sharedImageService
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileButton: ProfilePictureButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var viewModel = TimelineViewModel()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyStyle()
        setTitleViewContent(200)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Request user profile information
        viewModel.requestProfileInformation()
            .subscribe(onNext: { user in
                self.requestProfilePicture()
                }, onError: { error in
                    switch error {
                    case TwitterRequestError.NotAuthenticated:
                        self.presentViewController(StoryboardScene.Main.twitterLoginViewController(), animated: true, completion: nil)
                    default:
                        print("Failed to request profile information with error: \(error)")
                    }
                }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(self.disposeBag)
        
        loadTableView()
    }
    
    // MARK: Data Request
    
    func requestProfilePicture() {
        viewModel.requestProfilePicture()
            .subscribe(onNext: {
                self.profileButton.setBackgroundImage($0, forState: .Normal)
                }, onError: { error in
                    // handle error
                }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
        
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
            return cell
        }
        
        viewModel.requestTimeline()
            .bindTo(tableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(disposeBag)
        
        tableView
            .rx_itemSelected
            .map { indexPath in
                return (indexPath, self.dataSource.itemAtIndexPath(indexPath))
            }
            .subscribeNext { indexPath, model in
                // TODO: push new view on stack with all the tweets of a user
            }
            .addDisposableTo(disposeBag)
        
        tableView
            .rx_itemDeselected
            .subscribeNext { indexPath in
                
            }
            .addDisposableTo(disposeBag)
        
        tableView
            .rx_setDelegate(self)
            .addDisposableTo(disposeBag)
        
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
    
    // MARK: IBActions
    
    @IBAction func showProfile(sender: AnyObject) {
    }
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue) {
        
    }
}