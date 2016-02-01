source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

inhibit_all_warnings!
use_frameworks!

plugin 'cocoapods-keys', {
    :project => "TweetsCounter",
    :keys => [
    "FABRIC_API_KEY",
    "FABRIC_BUILD_SECRET",
    ]
}

target "TweetsCounter" do
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'TwitterKit'
    pod 'TwitterCore'
    
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxDataSources'
    pod 'RxAlamofire'
    
    pod 'Alamofire'
    pod 'Stash'
    pod 'ObjectMapper'
    pod 'Unbox'
    pod 'ReachabilitySwift'
end

target "TweetsCounterTests" do
    pod 'OHHTTPStubs'
    pod 'OHHTTPStubs/Swift'
    pod 'RxSwift'
    pod 'Fabric'
    pod 'TwitterKit'
    pod 'TwitterCore'
end
