//
//  AppDelegate.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 10/24/2018.
//  Copyright (c) 2018 Damjan Dabo. All rights reserved.
//

import UIKit
import Bugsnatch

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let emailConfig = EmailConfig()
        let bugsnatchConfig = BugsnatchConfig(
            trigger: ScreenshotTrigger(),
            triggerActionConfig: emailConfig,
            extraDebugInfoDelegate: self)
        Bugsnatch.shared.setup(config: bugsnatchConfig)

        return true
    }
}

extension AppDelegate: BugsnatchExtraDebugInfoDelegate {

    var extraDebugInfo: String? {
        return Date().debugDescription
    }
}
