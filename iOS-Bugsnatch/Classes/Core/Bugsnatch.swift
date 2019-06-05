//
//  Bugsnatch.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 22/03/2019.
//

import Foundation

public protocol TriggerActionConfig {}

public final class Bugsnatch {

    private init() {}

    public static let shared = Bugsnatch()
    var config: BugsnatchConfig?

    private var _trigger: Triggerable?

    public func setup(config: BugsnatchConfig, triggerActionConfig: TriggerActionConfig? = nil) {
        self.config = config
        _trigger = config.trigger
        _trigger?.delegate = self
    }

    public var bugTitle: String {
        guard let applicationName = ApplicationInfo.appName else { return "Bug report" }
        let postfix = config?.localization.titlePostfix ?? "bug report"
        return "\(applicationName) \(postfix)"
    }

    public var debugInfo: String {
        return [
            ApplicationInfo.appInfo,
            _deviceNameRow,
            _systemVersionRow,
            config?.shouldShowDeviceOrientation.mapTrue(to: _deviceOrientationRow)
            ]
            .compactMap { $0 }
            .joined(separator: "\n")
    }

    // MARK: - Private

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
}
