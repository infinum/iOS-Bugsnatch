//
//  BugsnatchConfig.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 22/03/2019.
//

import Foundation

public class BugsnatchConfig {

    public let shouldShowDeviceOrientation: Bool
    public let triggerType: Trigger.TriggerType

    public init(shouldShowDeviceOrientation: Bool, triggerType: Trigger.TriggerType = .screenshot) {
        self.shouldShowDeviceOrientation = shouldShowDeviceOrientation
        self.triggerType = triggerType
    }
}
