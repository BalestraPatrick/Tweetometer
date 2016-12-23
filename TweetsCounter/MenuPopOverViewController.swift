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
        case MenuOptions.refresh.rawValue:
            coordinator.refreshTimeline()
        case MenuOptions.logout.rawValue:
            coordinator.logout()
            break
        case MenuOptions.settings.rawValue:
            coordinator.presentSettings()
//            dismiss(animated: true) {
//                self.homeViewController?.present(StoryboardScene.Main.settingsViewController(), animated: true, completion: nil)
//            }
        default:
            break
        }
    }
}
