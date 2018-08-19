// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: Any> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: Any> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal protocol SegueType: RawRepresentable { }

internal extension UIViewController {
  func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    let identifier = segue.rawValue
    performSegue(withIdentifier: identifier, sender: sender)
  }
}

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum Login: StoryboardType {
    internal static let storyboardName = "Login"

    internal static let initialScene = InitialSceneType<Tweetometer.LogInViewController>(storyboard: Login.self)

    internal static let login = SceneType<Tweetometer.LogInViewController>(storyboard: Login.self, identifier: "Login")
  }
  internal enum Main: StoryboardType {
    internal static let storyboardName = "Main"

    internal static let initialScene = InitialSceneType<UINavigationController>(storyboard: Main.self)

    internal static let home = SceneType<Tweetometer.HomeViewController>(storyboard: Main.self, identifier: "Home")

    internal static let menuPopOver = SceneType<Tweetometer.MenuPopOverViewController>(storyboard: Main.self, identifier: "MenuPopOver")

    internal static let userDetail = SceneType<Tweetometer.UserDetailViewController>(storyboard: Main.self, identifier: "UserDetail")
  }
  internal enum Settings: StoryboardType {
    internal static let storyboardName = "Settings"

    internal static let initialScene = InitialSceneType<Tweetometer.SettingsViewController>(storyboard: Settings.self)

    internal static let settings = SceneType<Tweetometer.SettingsViewController>(storyboard: Settings.self, identifier: "Settings")
  }
  internal enum UserTopBar: StoryboardType {
    internal static let storyboardName = "UserTopBar"

    internal static let initialScene = InitialSceneType<Tweetometer.UserTopBarViewController>(storyboard: UserTopBar.self)
  }
}

internal enum StoryboardSegue {
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

private final class BundleToken {}
