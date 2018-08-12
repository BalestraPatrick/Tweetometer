//
//  MenuPopOverViewController.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/3/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import TweetometerKit

class MenuPopOverViewController: UITableViewController {
    
    let options = MenuDataSource().options
    weak var coordinator: MenuCoordinatorDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.MenuPopOverCellIdentifier.rawValue, for: indexPath) as! MenuOptionTableViewCell
        let option = options[indexPath.row]
        cell.configureCell(option)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case MenuOption.refresh.rawValue:
            coordinator.refreshTimeline()
        case MenuOption.share.rawValue:
            coordinator.share()
        case MenuOption.logout.rawValue:
            coordinator.logout()
        case MenuOption.settings.rawValue:
            coordinator.presentSettings()
        default:
            break
        }
    }
}
