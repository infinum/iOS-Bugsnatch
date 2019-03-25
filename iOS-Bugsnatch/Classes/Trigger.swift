//
//  Trigger.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 25/03/2019.
//

import Foundation

protocol TriggerDelegate: class {
    func didTrigger()
}

public class Trigger {

    var type: Trigger.TriggerType
    weak var delegate: TriggerDelegate?

    init?(type: Trigger.TriggerType?, delegate: TriggerDelegate) {
        guard let _type = type else { return nil }

        self.type = _type
        self.delegate = delegate
        _setup()
    }

    public enum TriggerType {
        case screenshot
        case shakeGesture
    }

    // MARK: - Private -

    private func _setup() {
        switch type {
        case .screenshot:
            _setupScreenshotTrigger()
        case .shakeGesture:
            _setupShakeGestureTrigger()
        }
    }

    private func _setupScreenshotTrigger() {
        NotificationCenter.default.addObserver(
            forName: .UIApplicationUserDidTakeScreenshot,
            object: nil,
            queue: .main) { [weak delegate] notification in
                delegate?.didTrigger()
        }
    }

    private func _setupShakeGestureTrigger() {
        // TODO: - implement -
    }
}
