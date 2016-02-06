//
//  UserDetailViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/6/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

final class UserDetailViewController: UIViewController {
    
    var selectedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        
        guard let user = selectedUser else { return }
        title = user.screenName
    }
}
