# Tweetometer

[![CircleCI](https://circleci.com/gh/BalestraPatrick/Tweetometer.svg?style=svg)](https://circleci.com/gh/BalestraPatrick/Tweetometer)

![Swift 3.0+](https://img.shields.io/badge/Swift-3.0%2B-orange.svg)
[![License](https://img.shields.io/badge/License-%40MIT-lightgrey.svg)](https://raw.githubusercontent.com/BalestraPatrick/Tweetometer/master/LICENSE)
[![Twitter: @BalestraPatrick](https://img.shields.io/badge/Twitter-%40BalestraPatrick-blue.svg)](https://twitter.com/BalestraPatrick)

![](header.png)

Tweetometer is an app to see who is tweeting in your Twitter timeline. It often happens to me that I check my timeline and I see a few hundreds tweets in just a few hours and I wonder "Who is spamming my timeline?".

### Usage
This project uses [CocoaPods](https://github.com/CocoaPods/CocoaPods/) to manage the dependencies. If you want to run the project, you first need to install the pods by doing `pod install`.

A few API keys are also required and you can add your own Fabric and Instabug keys by using [cocoapods keys](https://github.com/orta/cocoapods-keys). First install it by doing `gem install cocoapods-keys` and then add your keys and like this:

<pre>$ pod keys set FABRIC_API_KEY YOUR_API_KEY
$ pod keys set FABRIC_BUILD_SECRET YOUR_BUILD_SECRET
$ pod keys set INSTABUG_API_KEY YOUR_API_KEY</pre>


### Contribution
You're welcome to improve and add new features to the app! Check the [backlog](https://github.com/BalestraPatrick/Tweetometer/projects/1).

### Author
I'm Patrick Balestra, [@BalestraPatrick](http://www.twitter.com/BalestraPatrick) on Twitter.
