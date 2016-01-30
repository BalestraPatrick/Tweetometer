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

class HomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileButton: ProfilePictureButton!
    
    var viewModel = TimelineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.applyCustomization()
        
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
            ])
        
        items
            .bindTo(tableView.rx_itemsWithCellIdentifier(TableViewCell.UserCell.rawValue, cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .addDisposableTo(disposeBag)
        
        
        tableView
            .rx_modelSelected(String)
            .subscribeNext { value in
//                DefaultWireframe.presentAlert("Tapped `\(value)`")
            }
            .addDisposableTo(disposeBag)
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
        
        // Request timeline
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
                }, onCompleted: {
                    // handle completion
                }, onDisposed: nil)
            .addDisposableTo(disposeBag)
        
    }
    
    // MARK: IBActions
    
    @IBAction func showProfile(sender: AnyObject) {
    }
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue) {
        
    }
}