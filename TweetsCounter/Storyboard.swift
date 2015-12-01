//
//  Storyboard.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/1/15.
//  Copyright © 2015 Patrick Balestra. All rights reserved.
//
// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

protocol StoryboardSceneType {
    static var storyboardName : String { get }
}

extension StoryboardSceneType {
    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }
    
    static func initialViewController() -> UIViewController {
        return storyboard().instantiateInitialViewController()!
    }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
    func viewController() -> UIViewController {
        return Self.storyboard().instantiateViewControllerWithIdentifier(self.rawValue)
    }
    static func viewController(identifier: Self) -> UIViewController {
        return identifier.viewController()
    }
}

protocol StoryboardSegueType : RawRepresentable { }

extension UIViewController {
    func performSegue<S : StoryboardSegueType where S.RawValue == String>(segue: S, sender: AnyObject? = nil) {
        performSegueWithIdentifier(segue.rawValue, sender: sender)
    }
}

struct StoryboardScene {
    enum LaunchScreen : StoryboardSceneType {
        static let storyboardName = "LaunchScreen"
    }
    enum Main : String, StoryboardSceneType {
        static let storyboardName = "Main"
        
        case TwitterLogin = "TwitterLogin"
        static func twitterLoginViewController() -> TwitterLoginViewController {
            return Main.TwitterLogin.viewController() as! TwitterLoginViewController
        }
    }
}

struct StoryboardSegue {
    
}