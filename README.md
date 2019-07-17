# Bugsnatch

[![CI Status](https://img.shields.io/travis/Damjan Dabo/Bugsnatch.svg?style=flat)](https://travis-ci.org/Damjan Dabo/Bugsnatch)
[![Version](https://img.shields.io/cocoapods/v/Bugsnatch.svg?style=flat)](https://cocoapods.org/pods/Bugsnatch)
[![License](https://img.shields.io/cocoapods/l/Bugsnatch.svg?style=flat)](https://cocoapods.org/pods/Bugsnatch)
[![Platform](https://img.shields.io/cocoapods/p/Bugsnatch.svg?style=flat)](https://cocoapods.org/pods/Bugsnatch)

Bugsnatch is a lightweight bug reporting iOS library written in Swift. It creates a bug report template by collecting application and device information. It can be triggered via a shake gesture or by taking a screenshot.

### Features:
- collecting application and device information
- attaching a screenshot to the email
- comes in two variations: 
    - Email 
    - Productive
- fully configurable:
    - strings customization
    - selecting shake gesture or taking a screenshot for the trigger
    - adding a custom trigger
    - dynamically adding extra debug info

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. Example project is configured for the Email version.

## Requirements

* iOS 9.0+
* Xcode 10.2+
* Swift 5+

## Installation

Bugsnatch is available through [CocoaPods][1]. To install
it, simply add the following line to your Podfile:

* for Email version
```ruby
pod 'Bugsnatch/Email'
```

* for Productive version
```ruby
pod 'Bugsnatch/Productive'
```

## Author

Damjan Dabo, damjan.dabo@infinum.hr

Maintained by [Infinum][2]

<p align="center">
    <img src="infinum-logo.png" width="300" max-width="70%" alt="Infinum"/>
</p>

## License

Bugsnatch is available under the MIT license. See the LICENSE file for more info.

* Copyright (c) 2019 Zagreb University of Applied Sciences (TVZ)
* Copyright (c) 2019 Damjan Dabo
* Copyright (c) 2019 Infinum

[1]:    http://cocoapods.org
[2]:    https://infinum.co
