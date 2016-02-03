//
//  UIImage+Extensions.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 11/1/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation
import UIKit

extension Image {
    func forceLazyImageDecompression() -> Image {
        UIGraphicsBeginImageContext(CGSizeMake(1, 1))
        self.drawAtPoint(CGPointZero)
        UIGraphicsEndImageContext()
        return self
    }
}