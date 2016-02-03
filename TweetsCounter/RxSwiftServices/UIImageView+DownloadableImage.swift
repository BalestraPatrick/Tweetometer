//
//  UIImageView+DownloadableImage.swift
//  RxExample
//
//  Created by Vodovozov Gleb on 11/1/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

import UIKit

extension UIImageView {
    
    var rxex_downloadableImage: AnyObserver<DownloadableImage>{
        return self.rxex_downloadableImageAnimated(nil)
    }
    
    func rxex_downloadableImageAnimated(transitionType:String?) -> AnyObserver<DownloadableImage> {
        
        return AnyObserver { [weak self] event in
            
            guard let strongSelf = self else { return }
            MainScheduler.ensureExecutingOnScheduler()
            
            switch event{
            case .Next(let value):
                for subview in strongSelf.subviews {
                    subview.removeFromSuperview()
                }
                switch value{
                case .Content(let image):
                    strongSelf.rx_image.onNext(image)
                case .OfflinePlaceholder:
                    let label = UILabel(frame: strongSelf.bounds)
                    label.textAlignment = .Center
                    label.font = UIFont.systemFontOfSize(35)
                    label.text = "👻"
                    strongSelf.addSubview(label)
                }
            case .Error(let error):
                print("[UIImageView+DownloadableImage.swift] Failed to download an image with error: \(error)")
                break
            case .Completed:
                break
            }
        }
    }
}
