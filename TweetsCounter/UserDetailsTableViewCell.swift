//
//  UserDetailsTableViewCell.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 5/1/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import RxSwift

class UserDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let imageService = DefaultImageService.sharedImageService
    
    var downloadableImage: Observable<DownloadableImage>? {
        didSet {
            self.downloadableImage?
                .asDriver(onErrorJustReturn: DownloadableImage.OfflinePlaceholder)
                .drive(profileImage.rxex_downloadableImageAnimated(kCATransitionFade))
                .addDisposableTo(rx_disposeBag)
        }
    }
    
    func configure(user: User) {
        descriptionLabel.text = user.description
        downloadableImage = imageService.imageFromURL(user.profileImageURL!) ?? Observable.empty()
    }
    
}
