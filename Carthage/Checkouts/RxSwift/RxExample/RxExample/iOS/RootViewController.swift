//
//  RootViewController.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 4/6/15.
//  Copyright (c) 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation
import UIKit

public class RootViewController : UITableViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        // force load
        GitHubSearchRepositoriesAPI.sharedAPI.activityIndicator
        DefaultWikipediaAPI.sharedAPI
        DefaultImageService.sharedImageService
    }
}