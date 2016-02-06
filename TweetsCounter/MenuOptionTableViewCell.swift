//
//  MenuOptionTableViewCell.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/6/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

class MenuOptionTableViewCell: UITableViewCell {
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            self.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        } else {
            self.backgroundColor = UIColor.clearColor()
        }
    }
    
    func configureCell(option: Option) {
        backgroundColor = UIColor.clearColor()
        textLabel?.textColor = UIColor.whiteColor()
        layoutMargins = UIEdgeInsetsZero
        textLabel?.text = option.title
        imageView?.image = UIImage(named: option.image)
    }
}