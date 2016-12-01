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
        return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
    }
    static func viewController(_ identifier: Self) -> UIViewController {
        return identifier.viewController()
    }
}

protocol StoryboardSegueType : RawRepresentable { }

extension UIViewController {
    func performSegue<S : StoryboardSegueType>(_ segue: S, sender: AnyObject? = nil) where S.RawValue == String {
        self.performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}

struct StoryboardScene {
    enum LaunchScreen : StoryboardSceneType {
        static let storyboardName = "LaunchScreen"
    }
    enum Main : String, StoryboardSceneType {
        static let storyboardName = "Main"
        
        case Home = "Home"
        static func homeViewController() -> HomeViewController {
            return Main.Home.viewController() as! HomeViewController
        }
        
        case MenuPopOver = "MenuPopOver"
        static func menuPopOverViewController() -> MenuPopOverViewController {
            return Main.MenuPopOver.viewController() as! MenuPopOverViewController
        }
        
        case Settings = "Settings"
        static func settingsViewController() -> SettingsViewController {
            return Main.Settings.viewController() as! SettingsViewController
        }
        
        case Login = "Login"
        static func LoginViewController() -> LoginViewController {
            return Main.Login.viewController() as! LoginViewController
        }
        
        case UserDetail = "UserDetail"
        static func userDetailViewController() -> UserDetailViewController {
            return Main.UserDetail.viewController() as! UserDetailViewController
        }
    }
}

struct StoryboardSegue {
    enum Main : String, StoryboardSegueType {
        case MenuPopOver = "MenuPopOver"
        case UserDetail = "UserDetail"
    }
}
