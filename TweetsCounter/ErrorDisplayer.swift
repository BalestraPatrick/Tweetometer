//
//  ErrorDisplayer.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 2/8/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import RxSwift

class ErrorDisplayer: NSObject {

    func display(_ error: Error) {
        let error = error as NSError
//        DefaultWireframe.presentAlert(error.localizedDescription)
    }
}
