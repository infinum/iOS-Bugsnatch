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

    static private var _localization: BugsnatchLocalizationConfig? {
        return Bugsnatch.shared.config?.localization
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
        let applicationNameTitle = _localization?.applicationName
            ?? "Application name"
        let bundleIdTitle = _localization?.bundleId
            ?? "Bundle ID"
        let versionTitle = _localization?.version
            ?? "Application name"
        let buildNumberTitle = _localization?.buildNumber
            ?? "Build number"
        return [
            ApplicationInfo.appName.map { "\(applicationNameTitle): \($0)" },
            ApplicationInfo.bundleId.map { "\(bundleIdTitle): \($0)" },
            ApplicationInfo.version.map { "\(versionTitle): \($0)" },
            ApplicationInfo.buildNumber.map { "\(buildNumberTitle): \($0)" },
        ]
            .compactMap { $0 }
            .joined(separator: "\n")
    }
}
