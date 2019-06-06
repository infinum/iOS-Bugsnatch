//
//  Trigger.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 25/03/2019.
//

import Foundation

// MARK: - Trigger -

public protocol TriggerDelegate: class {
    func didTrigger()
}

public protocol Triggerable {
    var delegate: TriggerDelegate? { get set }
}

// MARK: - ScreenshotTrigger -

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
        ShakeGestureObserver.shared.subscribe(self)
    }
}

// MARK: - ShakeGestureTrigger -

extension ShakeGestureTrigger: ShakeGestureSubscriber {

    func shakeGestureDetected() {
        ScreenshotTaker.saveScreenshot()
        delegate?.didTrigger()
    }
}

protocol ShakeGestureSubscriber: class {
    func shakeGestureDetected()
}

class ShakeGestureObserver {

    public static let shared = ShakeGestureObserver()

    private var _subscribers = [ShakeGestureSubscriber]()

    private init() {}

    public func subscribe(_ newSubsriber: ShakeGestureSubscriber) {
        _subscribers.append(newSubsriber)
    }

    public func unsubscribe(_ subscriber: ShakeGestureSubscriber) {
        _subscribers = _subscribers.filter({ $0 !== subscriber })
    }

    public func shakeGestureDetected() {
        _subscribers.forEach({ $0.shakeGestureDetected() })
    }
}

extension UIWindow {

    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            ShakeGestureObserver.shared.shakeGestureDetected()
        }
    }
}
