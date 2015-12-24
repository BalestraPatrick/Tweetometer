source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

inhibit_all_warnings!
use_frameworks!

pod 'RxAlamofire', '~> 0.3'
pod 'Fabric'
pod 'Crashlytics'
pod 'TwitterKit'
pod 'TwitterCore'
pod 'Alamofire', '~> 3.0'
pod 'RxSwift', '~> 2.0.0-beta'
pod 'Stash'
pod 'ObjectMapper', '~> 1.0'

plugin 'cocoapods-keys', {
    :project => "TweetsCounter",
    :keys => [
    "FABRIC_API_KEY",
    "FABRIC_BUILD_SECRET",
    ]
}

target "TweetsCounterTests" do
    pod 'TwitterKit'
    pod 'OHHTTPStubs'
end
