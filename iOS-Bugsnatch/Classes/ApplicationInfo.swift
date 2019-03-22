//
//  Bugsnatch.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 22/03/2019.
//

import Foundation

public struct ApplicationInfo {

    static private var _bundle: Bundle {
        return Bundle.main
    }

    public static var appName: String? {
        return _bundle.infoDictionary?["CFBundleName"] as? String
    }

    public static var bundleId: String? {
        return _bundle.bundleIdentifier ?? nil
    }

    public static var version: String? {
        return _bundle.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    public static var buildNumber: String? {
        return _bundle.infoDictionary?["CFBundleVersion"] as? String
    }

    public static var appInfo: String {
        var appInfo = ""

        if let appName = ApplicationInfo.appName {
            let appNameRow = "Application name: \(appName)\n"
            appInfo = appInfo.appending(appNameRow)
        }

        if let bundleId = ApplicationInfo.bundleId {
            let bundleIdRow = "Bundle ID: \(bundleId)\n"
            appInfo = appInfo.appending(bundleIdRow)
        }

        if let version = ApplicationInfo.version {
            let versionRow = "Version: \(version)\n"
            appInfo = appInfo.appending(versionRow)
        }

        if let buildNumber = ApplicationInfo.buildNumber {
            let buildNumberRow = "Build number: \(buildNumber)\n"
            appInfo = appInfo.appending(buildNumberRow)
        }

        return appInfo
    }
}
