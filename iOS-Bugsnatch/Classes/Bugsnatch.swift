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

        let deviceNameRow = "Device: \(UIDevice.modelName)\n"
        let systemVersionRow = "OS: \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)\n"

        info = info.appending(deviceNameRow).appending(systemVersionRow)

        return info
    }
}
