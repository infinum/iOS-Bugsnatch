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
        return "\(applicationName) bug report"
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
        return "Device: \(Device.version.rawValue)"
    }

    private var _systemVersionRow: String {
        return "OS: \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
    }

    private var _deviceOrientationRow: String {
        return "Device orientation: \(_deviceOrientation)"
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
