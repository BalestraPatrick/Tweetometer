source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

plugin 'cocoapods-keys', {
    :project => "TweetsCounter",
    :keys => [
        "FABRIC_API_KEY",
        "FABRIC_BUILD_SECRET",
        "INSTABUG_API_KEY",
    ]
}

target 'TweetsCounter' do
  pod 'Presentr'
  pod 'ValueStepper'
  pod 'Whisper'
  # Easily tap hashtags and links
  pod 'ActiveLabel'
  # Custom pull to refresh component
  pod 'PullToRefresher', :git => 'https://github.com/BalestraPatrick/PullToRefresh'

 target 'TweetsCounterTests' do
    inherit! :search_paths
 end
end

target 'TweetometerKit' do
  pod 'Unbox'
  pod 'RealmSwift'
  pod 'TwitterKit'
  pod 'TwitterCore'
  pod 'Crashlytics'
  pod 'Fabric'
  # Faster bug reporting
  pod 'Instabug'
  # Networking libraries
  pod 'Alamofire'
  pod 'AlamofireImage'
  # Better User Defaults
  pod 'SwiftyUserDefaults'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
