//
//  ViewController.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 10/24/2018.
//  Copyright (c) 2018 Damjan Dabo. All rights reserved.
//

import UIKit
import Bugsnatch

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let productiveConfig = ProductiveConfig(organizationId: "1-infinum", projectId: 1116)
        let bugsnatchConfig = BugsnatchConfig(
            trigger: ScreenshotTrigger(),
            shouldShowDeviceOrientation: true,
            triggerActionConfig: productiveConfig)
        Bugsnatch.shared.setup(config: bugsnatchConfig)
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
