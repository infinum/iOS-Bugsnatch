# Bugsnatch

[![CI Status](https://img.shields.io/travis/Damjan Dabo/Bugsnatch.svg?style=flat)](https://travis-ci.org/Damjan Dabo/Bugsnatch)
[![Version](https://img.shields.io/cocoapods/v/Bugsnatch.svg?style=flat)](https://cocoapods.org/pods/Bugsnatch)
[![License](https://img.shields.io/cocoapods/l/Bugsnatch.svg?style=flat)](https://cocoapods.org/pods/Bugsnatch)
[![Platform](https://img.shields.io/cocoapods/p/Bugsnatch.svg?style=flat)](https://cocoapods.org/pods/Bugsnatch)

Bugsnatch is a lightweight bug reporting iOS library written in Swift. It creates a bug report template by collecting application and device information. It can be triggered via a shake gesture or by taking a screenshot.

It supports reporting bugs via an email or via the [Productive][1] tool.

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
    
## Setting up

### For the Email version

- Configure in `AppDelegate`:
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let bugsnatchConfig = BugsnatchConfig(
        trigger: ScreenshotTrigger(),
        triggerActionConfig: EmailConfig(),
        extraDebugInfoDelegate: self)
    Bugsnatch.shared.setup(config: bugsnatchConfig)

    return true
}
```

- Supporting extra debug info:
```swift 
extension AppDelegate: BugsnatchExtraDebugInfoDelegate {

    var extraDebugInfo: String? {
        return Date().debugDescription // example dynamic info
    }
}
```

- On iPhone, the native Mail app should be installed and an account linked.
- If using Gmail: on iPhone go to `Settings` -> `Passwords & Accounts` -> `Gmail` and enable Mail.
- Removing "Sent from my iPhone" signature: on iPhone go to `Settings` -> `Mail` -> scroll down -> `Signature` and delete text.

### For the Productive version

- Configure in `AppDelegate`:
```swift 
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // can be found in Productive URL, e.g. https://app.productive.io/someOrganizationName/projects/12345
    let organizationName = "someOrganizationName"
    let projectId = 12345

    let productiveConfig = ProductiveConfig(organizationId: organizationName, projectId: projectId)
    let bugsnatchConfig = BugsnatchConfig(
        trigger: ScreenshotTrigger(),
        triggerActionConfig: productiveConfig)
    Bugsnatch.shared.setup(config: bugsnatchConfig)

    return true
}
```

- Add `productiveScript.js` in `Build Phases` -> `Copy Bundle Resources` and remove it from `Compile Sources`.
- Add `NSCameraUsageDescription` to `Info.plist` so app wouldn't crash when trying to attach a new photo to the Productive task in WebView.

### Adding a custom trigger

Creating your own trigger for triggering Bugsnatch is simple: 
1. conform to `Triggerable` protocol
2. call `didTrigger()` on `TriggerDelegate`

### Extra setup

- When using `ShakeGestureTrigger`, add `NSPhotoLibraryAddUsageDescription`to `Info.plist` for saving a screenshot on the device.

## Example project

To run the example project, clone the repo, and run `pod install` from the Example directory first. Example project is configured for the Email version.

## Requirements

* iOS 9.0+
* Xcode 10.2+
* Swift 5+

## Installation

Bugsnatch is available through [CocoaPods][2]. To install
it, simply add the following line to your Podfile:

* for the Email version
```ruby
pod 'Bugsnatch/Email'
```

* for the Productive version
```ruby
pod 'Bugsnatch/Productive'
```

## Author

Damjan Dabo, damjan.dabo@infinum.hr

Maintained by [Infinum][3]

<p align="center">
    <img src="infinum-logo.png" width="300" max-width="70%" alt="Infinum"/>
</p>

## License

Bugsnatch is available under the MIT license. See the LICENSE file for more info.

* Copyright (c) 2019 Zagreb University of Applied Sciences (TVZ)
* Copyright (c) 2019 Damjan Dabo
* Copyright (c) 2019 Infinum

[1]:    https://www.productive.io
[2]:    http://cocoapods.org
[3]:    https://infinum.co
