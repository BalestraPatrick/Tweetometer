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
    
    var viewModel = TimelineViewModel()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyStyle()
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
        tableView.rowHeight = 70.0
        
        dataSource.configureCell = { [weak self] (table, indexPath, user) in
            guard let cell = table.dequeueReusableCellWithIdentifier(TableViewCell.UserCellIdentifier.rawValue) as? UserTableViewCell else {
                fatalError("Could not create cell with identifier \(TableViewCell.UserCellIdentifier.rawValue) in UITableView: \(table)")
            }
            cell.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
            cell.screenName = user.name
            cell.username = user.screenName
            cell.numberOfFollowers = user.followersCount
            cell.numberOfFollowing = user.followingCount
            cell.numberOfTweets = user.tweets?.count ?? 0
            cell.downloadableImage = self?.imageService.imageFromURL(user.profileImageURL!) ?? Observable.empty()
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
            .rx_setDelegate(self)
            .addDisposableTo(disposeBag)
        
    }
    
    //    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let label = UILabel(frame: CGRect.zero)
    //        label.text = dataSource.sectionAtIndex(section).model ?? ""
    //        return label
    //    }
    
    // MARK: IBActions
    
    @IBAction func showProfile(sender: AnyObject) {
    }
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue) {
        
    }
}