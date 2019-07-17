//
//  Bundle+extension.swift
//  Bugsnatch
//
//  Created by Damjan Dabo on 17/07/2019.
//

import Foundation

extension Bundle {

    /// Returns bundle display name.
    public var displayName: String? {
        return self.infoDictionary?["CFBundleDisplayName"] as? String
    }

    /// Returns bundle name.
    public var name: String? {
        return self.infoDictionary?["CFBundleName"] as? String
    }

    /// Returns bundle ID.
    public var bundleId: String? {
        return self.bundleIdentifier
    }

    /// Returns application version.
    public var version: String? {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    /// Returns application build number.
    public var buildNumber: String? {
        return self.infoDictionary?["CFBundleVersion"] as? String
    }
}
