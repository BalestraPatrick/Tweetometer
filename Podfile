source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

inhibit_all_warnings!
use_frameworks!

target "TweetsCounter" do
    pod 'RxAlamofire'
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'TwitterKit'
    pod 'TwitterCore'
    pod 'Alamofire', '~> 3.0'
    pod 'RxSwift', '~> 2.0.0-beta'
    pod 'Stash'
    pod 'ObjectMapper', '~> 1.0'
    pod 'Unbox'
end

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
    pod 'OHHTTPStubs/Swift'
end
