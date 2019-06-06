//
//  BugsnatchConfig.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 22/03/2019.
//

import Foundation

public struct BugsnatchConfig {

    let trigger: Triggerable
    let shouldShowDeviceOrientation: Bool
    let triggerActionConfig: TriggerActionConfig?
    let localization: BugsnatchLocalizationConfig
    var extraDebugInfo: String?

    public init(
        trigger: Triggerable,
        shouldShowDeviceOrientation: Bool = false,
        triggerActionConfig: TriggerActionConfig? = nil,
        localization: BugsnatchLocalizationConfig = BugsnatchLocalizationConfig(),
        extraDebugInfo: String? = nil
    ) {
        self.trigger = trigger
        self.shouldShowDeviceOrientation = shouldShowDeviceOrientation
        self.triggerActionConfig = triggerActionConfig
        self.localization = localization
        self.extraDebugInfo = extraDebugInfo
    }
}

public struct BugsnatchLocalizationConfig {

    let titlePostfix: String
    let applicationName: String
    let bundleId: String
    let version: String
    let buildNumber: String
    let device: String
    let os: String
    let orientation: String?

    public init(
        titlePostfix: String = "bug report",
        applicationName: String = "Application name",
        bundleId: String = "Bundle ID",
        version: String = "Version",
        buildNumber: String = "Build number",
        device: String = "Device",
        os: String = "OS",
        orientation: String? = "Device orientation"
    ) {
        self.titlePostfix = titlePostfix
        self.applicationName = applicationName
        self.bundleId = bundleId
        self.version = version
        self.buildNumber = buildNumber
        self.device = device
        self.os = os
        self.orientation = orientation
    }
}
