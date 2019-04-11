//
//  Trigger.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 25/03/2019.
//

import Foundation

public protocol TriggerDelegate: class {
    func didTrigger()
}

public protocol Triggerable {
    var delegate: TriggerDelegate? { get set }
}

public class ScreenshotTrigger: Triggerable {

    weak public var delegate: TriggerDelegate?

    public init() {
        _setup()
    }

    private func _setup() {
        NotificationCenter.default.addObserver(
            forName: UIApplication.userDidTakeScreenshotNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            self?.delegate?.didTrigger()
        }
    }
}

public class ShakeGestureTrigger: Triggerable {

    weak public var delegate: TriggerDelegate?

    public init() {
        _setup()
    }

    private func _setup() {
        // TODO: - implement -
    }
}
