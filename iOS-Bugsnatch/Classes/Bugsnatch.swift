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
    private var _trigger: Trigger?

    public func setup(config: BugsnatchConfig) {
        _config = config
        _setupTrigger()
    }

    public var debugInfo: String {
        return [
            ApplicationInfo.appInfo,
            _deviceNameRow,
            _systemVersionRow,
            _config?.shouldShowDeviceOrientation.mapTrue(to: _deviceOrientationRow)
        ]
            .compactMap { $0 }
            .joined(separator: "\n")
    }

    // MARK: - Private

    private func _setupTrigger() {
        _trigger = Trigger(type: _config?.triggerType, delegate: self)
    }

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

    private func _saveScreenshotIfNeeded() {
        guard _config?.triggerType != .screenshot else { return }
        ScreenshotTaker.saveScreenshot()
    }
}

extension Bugsnatch: TriggerDelegate {

    func didTrigger() {
        // TODO: - do expected action -
        print(debugInfo)
        _saveScreenshotIfNeeded()
        ProductiveViewController.present()
    }
}
