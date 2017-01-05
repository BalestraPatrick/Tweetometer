//
//  MenuOptionsDataSource.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/5/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

/// Definition of the option fields.
public struct Option {
    public let image: String
    public let title: String
}

/// The options to be presented in the menu.
///
/// - refresh: Refresh the current timeline.
/// - logout: Logout the user.
/// - settings: Open the settings.
public enum MenuOption: Int {
    case refresh
    case share
    case logout
    case settings
}

public final class MenuDataSource {

    /// The options for the menu.
    public var options: [Option]
    
    public init () {
        self.options = [Option(image: "refresh", title: "Refresh"),
                        Option(image: "share", title: "Share"),
                        Option(image: "logout", title: "Logout"),
                        Option(image: "settings", title: "Settings")]
    }
}
