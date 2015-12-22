# TweetsCounter

![](https://travis-ci.org/BalestraPatrick/TweetsCounter.svg?branch=master)

Tweets Counter is an app to see who is tweeting a lot in your Twitter timeline. It often happens to me that I check my timeline and I see a few hundreds tweets in just a few hours and I wonder "Who is spamming my timeline?". 

This is a WIP. The project is written in Swift 2.0 and it uses the Fabric SDK to access Twitter's API.

### Usage
This project uses [CocoaPods](https://github.com/CocoaPods/CocoaPods/) to manage the dependencies. If you want to run the project, you first need to install the pods by doing `pod install`.

Fabric is used and you need to add your own API key by using [cocoapods keys](https://github.com/orta/cocoapods-keys) if you want to use the project. First install the gem (if not already installed) by doing `gem install cocoapods-keys` and then add your API Key and Build Secret like this:

<pre>$ pod keys set FABRIC_API_KEY YOUR_API_KEY_HERE
$ pod keys set FABRIC_BUILD_SECRET YOUR_BUILD_SECRET_HERE</pre>


### Contribution
You're welcome to improve and add new features to the app. 

### Author
I'm Patrick Balestra, [@BalestraPatrick](http://www.twitter.com/BalestraPatrick) on Twitter.
