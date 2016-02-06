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
        applyStyle()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCell.MenuPopOverCellIdentifier.rawValue, forIndexPath: indexPath) as! MenuOptionTableViewCell
        let option = options[indexPath.row]
        cell.configureCell(option)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: perform selected option
        dismissViewControllerAnimated(true, completion: nil)
    }
}
