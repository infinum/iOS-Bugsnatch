//
//  BugsnatchConfig.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 22/03/2019.
//

import Foundation

public class BugsnatchConfig {

    public let shouldShowDeviceOrientation: Bool
    public let trigger: Triggerable

    public init(shouldShowDeviceOrientation: Bool, trigger: Triggerable) {
        self.shouldShowDeviceOrientation = shouldShowDeviceOrientation
        self.trigger = trigger
    }
}
