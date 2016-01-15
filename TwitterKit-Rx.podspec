Pod::Spec.new do |s|
s.name             = "TwitterKit-Rx"
s.version          = "0.1.0"
s.summary          = "RxSwift extension to interact with the Twitter API via TwitterKit."

s.homepage         = "https://github.com/BalestraPatrick/TwitterKit-Rx"
s.license          = 'MIT'
s.author           = { "Patrick Balestra" => "me@patrickbalestra.com" }
s.source           = { :git => "https://github.com/BalestraPatrick/TwitterKit-Rx.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/BalestraPatrick'

s.platform         = :ios, '8.0'
s.requires_arc     = true

s.source_files = 'Pod/Classes/**/*'
s.resource_bundles = {
'TwitterKit-Rx' => ['Pod/Assets/*.png']
}

s.dependency "RxSwift", '~> 2.0.0'

end
