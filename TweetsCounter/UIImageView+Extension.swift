//
//  UIImageView+Extension.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/2/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum DownloadableImage {
    case Content(image:UIImage)
    case OfflinePlaceholder
    
}

extension UIImageView {
    
    func rxex_downloadableImageAnimated(transitionType: String?) -> AnyObserver<DownloadableImage> {
        
        return AnyObserver { [weak self] event in
            
            guard let strongSelf = self else { return }
            MainScheduler.ensureExecutingOnScheduler()
            
            switch event {
            case .Next(let value):
                for subview in strongSelf.subviews {
                    subview.removeFromSuperview()
                }
                switch value {
                case .Content(let image):
                    strongSelf.rx_image.onNext(image)
                case .OfflinePlaceholder:
                    let label = UILabel(frame: strongSelf.bounds)
                    label.textAlignment = .Center
                    label.font = UIFont.systemFontOfSize(35)
                    label.text = "⚠️"
                    strongSelf.addSubview(label)
                }
            case .Error(let error):
                print(error)
//                bindingErrorToInterface(error)
                break
            case .Completed:
                break
            }
        }
    }
}