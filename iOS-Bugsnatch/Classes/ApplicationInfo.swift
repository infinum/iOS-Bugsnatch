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
        return [
            ApplicationInfo.appName.map { "Application name: \($0)" },
            ApplicationInfo.bundleId.map { "Bundle ID: \($0)" },
            ApplicationInfo.version.map { "Version: \($0)" },
            ApplicationInfo.buildNumber.map { "Build number: \($0)" },
        ]
            .compactMap { $0 }
            .joined(separator: "\n")
    }
}
