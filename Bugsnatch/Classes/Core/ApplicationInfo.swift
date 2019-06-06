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

    static private var _versionBuildNumber: String? {
        guard let versionBuildNumberDisplayType = Bugsnatch.shared.config?.versionBuildNumberDisplayType else { return nil }

        switch versionBuildNumberDisplayType {
        case .separated:
            return _versionBuildNumberSeparated
        case .joined:
            return _versionBuildNumberJoined
        }
    }

    static private var _versionBuildNumberSeparated: String? {
        let versionTitle = _localization?.version
            ?? "Version"
        let buildNumberTitle = _localization?.buildNumber
            ?? "Build number"

        return [
            ApplicationInfo.version.map { "\(versionTitle): \($0)" },
            ApplicationInfo.buildNumber.map { "\(buildNumberTitle): \($0)" }
        ]
            .compactMap { $0 }
            .joined(separator: "\n")
    }

    static private var _versionBuildNumberJoined: String? {
        guard
            let version = ApplicationInfo.version,
            let buildNumber = ApplicationInfo.buildNumber
        else { return nil }

        let versionBuildNumberTitle = _localization?.versionBuildNumber ?? "Version and build number"
        return "\(versionBuildNumberTitle): \(version)-\(buildNumber)"
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

        return [
            ApplicationInfo.appName.map { "\(applicationNameTitle): \($0)" },
            ApplicationInfo.bundleId.map { "\(bundleIdTitle): \($0)" },
            _versionBuildNumber
        ]
            .compactMap { $0 }
            .joined(separator: "\n")
    }
}
