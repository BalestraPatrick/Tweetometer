//
//  ViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/19/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileButton: ProfilePictureButton!
    
    var viewModel = TimelineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.applyCustomization()
        
    }
    
    override func viewDidAppear(animated: Bool) {
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
                
                }, onError: { error in
                    
                }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(self.disposeBag)
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
            .addDisposableTo(self.disposeBag)
        
    }
    
    // MARK: IBActions
    
    @IBAction func showProfile(sender: AnyObject) {
        // Show user profile information and settings
    }
}