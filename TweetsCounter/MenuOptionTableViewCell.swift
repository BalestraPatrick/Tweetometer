//
//  MenuOptionTableViewCell.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/6/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit

final class MenuOptionTableViewCell: UITableViewCell {
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            self.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        } else {
            self.backgroundColor = .clear
        }
    }
    
    func configureCell(_ option: Option) {
        backgroundColor = .clear
        textLabel?.textColor = .white
        layoutMargins = UIEdgeInsets.zero
        textLabel?.text = option.title
        imageView?.image = UIImage(named: option.image)
    }
}
