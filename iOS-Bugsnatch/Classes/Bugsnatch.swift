//
//  Bugsnatch.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 22/03/2019.
//

import Foundation

public final class Bugsnatch {

    private init() {}

    public static let shared = Bugsnatch()

    private var _config: BugsnatchConfig?

    public func setup(config: BugsnatchConfig) {
        _config = config
    }

    public var debugInfo: String {
        var info = ApplicationInfo.appInfo

        info = info.appending(_deviceNameRow).appending(_systemVersionRow)

        if _config?.shouldShowDeviceOrientation == true {
            info.append(_deviceOrientationRow)
        }

        return info
    }

    // MARK: - Private

    private var _deviceNameRow: String {
        return "Device: \(UIDevice.modelName)\n"
    }

    private var _systemVersionRow: String {
        return "OS: \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)\n"
    }

    private var _deviceOrientationRow: String {
        return "Device orientation: \(_deviceOrientation)\n"
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
