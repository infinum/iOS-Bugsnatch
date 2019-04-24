//
//  BugsnatchConfig.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 22/03/2019.
//

import Foundation

public class BugsnatchConfig {

    let trigger: Triggerable
    let shouldShowDeviceOrientation: Bool
    let triggerActionConfig: TriggerActionConfig?

    public init(trigger: Triggerable, shouldShowDeviceOrientation: Bool = false, triggerActionConfig: TriggerActionConfig? = nil) {
        self.trigger = trigger
        self.shouldShowDeviceOrientation = shouldShowDeviceOrientation
        self.triggerActionConfig = triggerActionConfig
    }
}
