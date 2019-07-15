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

    static private var _defaultLocalization: BugsnatchLocalizationConfig {
        return BugsnatchLocalizationConfig()
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
            ?? _defaultLocalization.version
        let buildNumberTitle = _localization?.buildNumber
            ?? _defaultLocalization.buildNumber

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

        let versionBuildNumberTitle = _localization?.versionBuildNumber ?? _defaultLocalization.versionBuildNumber
        return "\(versionBuildNumberTitle): \(version)-\(buildNumber)"
    }

    /// Returns application name.
    public static var appName: String? {
        return _bundle.infoDictionary?["CFBundleDisplayName"] as? String ?? _bundle.infoDictionary?["CFBundleName"] as? String
    }

    /// Returns bundle ID.
    public static var bundleId: String? {
        return _bundle.bundleIdentifier ?? nil
    }

    /// Returns application version.
    public static var version: String? {
        return _bundle.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    /// Returns application build number.
    public static var buildNumber: String? {
        return _bundle.infoDictionary?["CFBundleVersion"] as? String
    }

    /// Returns application name, bundle ID, application version and build number with descriptive titles separated by a new line.
    /// Can be localized by the BugsnatchConfig.
    ///
    /// Example:
    ///
    ///     Application name: Bugsnatch_Example
    ///     Bundle ID: org.cocoapods.demo.Bugsnatch-Example
    ///     Version: 1.0
    ///     Build number: 1
    ///
    public static var appInfo: String {
        let applicationNameTitle = _localization?.applicationName
            ?? _defaultLocalization.applicationName
        let bundleIdTitle = _localization?.bundleId
            ?? _defaultLocalization.bundleId

        let applicationNameRow = ApplicationInfo.appName.map { "\(applicationNameTitle): \($0)" }
        let bundleIdRow = ApplicationInfo.bundleId.map { "\(bundleIdTitle): \($0)" }

        return [
            applicationNameRow,
            Bugsnatch.shared.config?.shouldShowBundleId.mapTrue(to: bundleIdRow),
            _versionBuildNumber
        ]
            .compactMap { $0 }
            .joined(separator: "\n")
    }
}
