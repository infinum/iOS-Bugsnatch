//
//  Bugsnatch.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 22/03/2019.
//

import Foundation

/// Used for configuring trigger actions.
public protocol TriggerActionConfig {}

/// Used for adding extra debug info.
public protocol BugsnatchExtraDebugInfoDelegate {
    /// Implement this computed property for adding extra debug info.
    var extraDebugInfo: String? { get }
}

/// A main Bugsnatch class. Use its singleton instance for setting setting up the Bugsnatch functionalities.
public final class Bugsnatch {

    private init() {}

    /// Returns Bugsnatch singleton.
    public static let shared = Bugsnatch()

    /// The main config for Bugsnatch.
    var config: BugsnatchConfig?

    /// Returns the bug title.
    /// Can be localized by the config.
    public var bugTitle: String {
        guard let applicationName = ApplicationInfo.appName else { return "Bug report" }
        let postfix = config?.localization.titlePostfix ?? "bug report"
        return "\(applicationName) \(postfix)"
    }

    /// Returns the whole debug info separated by a new line.
    /// Can be localized and configured by the BugsnatchConfig.
    ///
    /// Example:
    ///
    ///     Application name: Bugsnatch Example
    ///     Bundle ID: org.cocoapods.demo.Bugsnatch-Example
    ///     Version: 1.0
    ///     Build number: 1
    ///     Device: iPhone X
    ///     OS: iOS 12.1.4
    ///     Device orientation: portrait
    ///     Some extra debug info...
    ///
    public var debugInfo: String {
        return [
            ApplicationInfo.appInfo,
            _deviceNameRow,
            _systemVersionRow,
            config?.shouldShowDeviceOrientation.mapTrue(to: _deviceOrientationRow),
            config?.extraDebugInfoDelegate?.extraDebugInfo
        ]
            .compactMap { $0 }
            .joined(separator: "\n")
    }

    // MARK: - Private properties -

    private var _trigger: Triggerable?

    private var _deviceNameRow: String {
        let rowName = config?.localization.device ?? "Device"
        return "\(rowName): \(Device.version.rawValue)"
    }

    private var _systemVersionRow: String {
        let rowName = config?.localization.os ?? "OS"
        return "\(rowName): \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
    }

    private var _deviceOrientationRow: String {
        let rowName = config?.localization.orientation ?? "Device orientation"
        return "\(rowName): \(_deviceOrientation)"
    }

    private var _deviceOrientation: String {
        switch UIApplication.shared.statusBarOrientation {
        case .unknown:
            return "unknown"
        case .portrait:
            return "portrait"
        case .portraitUpsideDown:
            return "portraitUpsideDown"
        case .landscapeLeft:
            return "landscapeLeft"
        case .landscapeRight:
            return "landscapeRight"
        }
    }

    // MARK: - Public methods -

    /// Sets up the Bugsnatch with the BugsnatchConfig.
    ///
    /// This method must be called for Bugsnatch to work. BugsnatchConfig contains Trigger which determines Bugsnatch's behaviour.
    ///
    /// - Parameter config: A config which is essential for Bugsnatch to work.
    public func setup(config: BugsnatchConfig) {
        self.config = config
        _trigger = config.trigger
        _trigger?.delegate = self
    }
}
