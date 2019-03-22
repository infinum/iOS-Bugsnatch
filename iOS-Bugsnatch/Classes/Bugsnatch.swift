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

    public static var debugInfo: String {
        var info = ApplicationInfo.appInfo

        let deviceInfo = "Device: \(UIDevice.modelName)"
        info = info.appending(deviceInfo)

        return info
    }
}
