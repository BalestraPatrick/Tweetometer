//
//  MenuOptionsDataSource.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/5/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

class MenuOptionsDataSource {
    
    struct Option {
        let image: String
        let title: String
    }
    
    var options: [Option]
    
    init () {
        self.options = [Option(image: "Refresh", title: "Refresh"),
                        Option(image: "Logout", title: "Logout"),
                        Option(image: "About", title: "About"),]
    }
}
