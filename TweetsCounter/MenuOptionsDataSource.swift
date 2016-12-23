//
//  MenuOptionsDataSource.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/5/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit


/// Definition of the option fields.
struct Option {
    let image: String
    let title: String
}


/// The options to be presented in the menu.
///
/// - refresh: Refresh the current timeline.
/// - logout: Logout the user.
/// - settings: Open the settings.
enum MenuOptions: Int {
    case refresh
    case logout
    case settings
}

final class MenuOptionsDataSource {

    /// The options for the menu.
    var options: [Option]
    
    init () {
        self.options = [Option(image: "refresh", title: "Refresh"),
                        Option(image: "logout", title: "Logout"),
                        Option(image: "settings", title: "Settings")]
    }
}
