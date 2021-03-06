//
//  BugsnatchConfig.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 22/03/2019.
//

import Foundation

public struct BugsnatchConfig {

    let trigger: Triggerable
    let triggerActionConfig: TriggerActionConfig?
    let localization: BugsnatchLocalizationConfig
    let shouldShowBundleId: Bool
    let shouldShowDeviceOrientation: Bool
    let versionBuildNumberDisplayType: VersionBuildNumberDisplayType
    var extraDebugInfoDelegate: BugsnatchExtraDebugInfoDelegate?

    public init(
        trigger: Triggerable,
        triggerActionConfig: TriggerActionConfig? = nil,
        localization: BugsnatchLocalizationConfig = BugsnatchLocalizationConfig(),
        shouldShowBundleId: Bool = false,
        shouldShowDeviceOrientation: Bool = false,
        versionBuildNumberDisplayType: VersionBuildNumberDisplayType = .separated,
        extraDebugInfoDelegate: BugsnatchExtraDebugInfoDelegate? = nil
    ) {
        self.trigger = trigger
        self.shouldShowBundleId = shouldShowBundleId
        self.shouldShowDeviceOrientation = shouldShowDeviceOrientation
        self.triggerActionConfig = triggerActionConfig
        self.localization = localization
        self.versionBuildNumberDisplayType = versionBuildNumberDisplayType
        self.extraDebugInfoDelegate = extraDebugInfoDelegate
    }
}

public struct BugsnatchLocalizationConfig {

    let titlePostfix: String
    let applicationName: String
    let bundleId: String
    let version: String
    let buildNumber: String
    let versionBuildNumber: String
    let device: String
    let os: String
    let orientation: String

    public init(
        titlePostfix: String = "bug report",
        applicationName: String = "Application name",
        bundleId: String = "Bundle ID",
        version: String = "Version",
        buildNumber: String = "Build number",
        versionBuildNumber: String = "Version and build number",
        device: String = "Device",
        os: String = "OS",
        orientation: String = "Device orientation"
    ) {
        self.titlePostfix = titlePostfix
        self.applicationName = applicationName
        self.bundleId = bundleId
        self.version = version
        self.buildNumber = buildNumber
        self.versionBuildNumber = versionBuildNumber
        self.device = device
        self.os = os
        self.orientation = orientation
    }
}

public enum VersionBuildNumberDisplayType {
    case joined
    case separated
}
