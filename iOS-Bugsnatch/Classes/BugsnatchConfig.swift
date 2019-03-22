//
//  BugsnatchConfig.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 22/03/2019.
//

import Foundation

public struct BugsnatchConfig {

    public let shouldShowDeviceOrientation: Bool

    public init(shouldShowDeviceOrientation: Bool) {
        self.shouldShowDeviceOrientation = shouldShowDeviceOrientation
    }
}
