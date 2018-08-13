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
        
        case home = "Home"
        static func homeViewController() -> HomeViewController {
            return Main.home.viewController() as! HomeViewController
        }
        
        case menuPopOver = "MenuPopOver"
        static func menuPopOverViewController() -> MenuPopOverViewController {
            return Main.menuPopOver.viewController() as! MenuPopOverViewController
        }
        
        case settings = "Settings"
        static func settingsViewController() -> SettingsViewController {
            return Main.settings.viewController() as! SettingsViewController
        }
        
        case login = "Login"
        static func LogInViewController() -> LogInViewController {
            return Main.login.viewController() as! LogInViewController
        }
        
        case userDetail = "UserDetail"
        static func userDetailViewController() -> UserDetailViewController {
            return Main.userDetail.viewController() as! UserDetailViewController
        }
    }
}

struct StoryboardSegue {
    enum Main : String, StoryboardSegueType {
        case menuPopOver
        case userDetail
    }
}
