//
//  ViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 10/19/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileButton: ProfilePictureButton!
    
    var viewModel = TimelineViewModel() {
        didSet {
            viewModel.profilePicture.bindAndFire {
                [unowned self] in
                self.profileButton.setBackgroundImage($0, forState: .Normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.applyCustomization()
    }
    
    override func viewDidAppear(animated: Bool) {
        viewModel.checkAuthentication { (error) in
            guard let error = error else { return }
            switch error {
            case AuthenticationError.NotAuthenticated:
                self.presentViewController(StoryboardScene.Main.twitterLoginViewController(), animated: true, completion: nil)
            default:
                print("Unknown Error occured")
            }
        }
    }
    
    @IBAction func showProfile(sender: AnyObject) {
        viewModel.requestProfilePicture()
    }
}