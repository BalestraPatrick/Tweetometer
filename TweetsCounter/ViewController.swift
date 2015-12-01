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
        
    }
    
    override func viewDidAppear(animated: Bool) {
        do {
            let result = try Tweets().startFetching()
            print("Analyze Tweets! \(result)")
        }
        catch TwitterError.NotAuthenticated {
            self.presentViewController(StoryboardScene.Main.twitterLoginViewController(), animated: true, completion: nil)
        }
        catch TwitterError.Unknown {
            print("Unknown Error occured")
        }
        catch {
            
        }
    }
    
}

