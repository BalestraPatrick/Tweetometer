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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileButton: ProfilePictureButton!
    
    var viewModel = TimelineViewModel()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyStyle()
        loadTableView()
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
        
        viewModel.requestTimeline()
            .subscribe(onNext: { timeline in
                print(timeline)
                }, onError: { error in
                    
                }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
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
        dataSource.configureCell = { table, indexPath, viewModel in
            guard let cell = table.dequeueReusableCellWithIdentifier(TableViewCell.UserCellIdentifier.rawValue) as? UserTableViewCell else {
                fatalError("Could not create cell with identifier \(TableViewCell.UserCellIdentifier.rawValue) in UITableView: \(table)")
            }
            cell.textLabel?.text = "\(viewModel) @ row \(indexPath.row)"
            return cell
        }
//        let items = Observable.just([
//            SectionModel(model: "First section", items: [2])
//            ])
//        viewModel.requestTimeline()
//            items
//            .bindTo(tableView.rx_itemsWithDataSource(dataSource))
//            .addDisposableTo(disposeBag)
        
//        tableView
//            .rx_itemSelected
//            .map { indexPath in
//                return (indexPath, self.dataSource.itemAtIndexPath(indexPath))
//            }
//            .subscribeNext { indexPath, model in
//                // TODO: push new view on stack with all the tweets of a user
//            }
//            .addDisposableTo(disposeBag)
//        
//        tableView
//            .rx_setDelegate(self)
//            .addDisposableTo(disposeBag)
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect.zero)
        label.text = dataSource.sectionAtIndex(section).model ?? ""
        return label
    }
    
    // MARK: IBActions
    
    @IBAction func showProfile(sender: AnyObject) {
    }
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue) {
        
    }
}