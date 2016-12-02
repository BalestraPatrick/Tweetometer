// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

extension UIImage {
    enum Asset: String {
        case close = "close"
        case detail = "detail"
        case heartIcon = "HeartIcon"
        case info = "info"
        case logout = "logout"
        case menu = "Menu"
        case placeholder = "placeholder"
        case refresh = "refresh"
        case retweetIcon = "RetweetIcon"
        case settings = "settings"

        var image: UIImage {
            return UIImage(asset: self)
        }
    }

    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}
