//
//  MenuPopOverViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/3/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

class MenuPopOverViewController: UITableViewController {
    
    let options = MenuOptionsDataSource().options
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alwaysBounceVertical = false
        preferredContentSize = CGSize(width: 200, height: 44 * options.count)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCell.MenuPopOverCellIdentifier.rawValue, forIndexPath: indexPath) as UITableViewCell
        let option = options[indexPath.row]
        cell.textLabel?.text = option.title
        cell.imageView?.image = UIImage(named: option.image)
        return cell
    }
}
