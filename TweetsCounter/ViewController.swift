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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let req = TweetsRequest()

    }
    
    override func viewDidAppear(animated: Bool) {
        let login = TwitterLoginViewController()
        self.presentViewController(login, animated: true, completion: nil)
    }
}

