//
//  Trigger.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 25/03/2019.
//

import Foundation

// MARK: - Trigger -

/// Bugsnatch needs to conform to this delegate so it can receive triggers. Conform to this trigger in Bugsnatch extension when implementing a new trigger.
public protocol TriggerDelegate: class {
    /// This delegate method is called when trigger is triggered. It should call appropriate Bugsnatch action.
    func didTrigger()
}

/// When making a trigger, it should conform to this protocol.
public protocol Triggerable {
    var delegate: TriggerDelegate? { get set }
}

// MARK: - ScreenshotTrigger -

/// Trigger used for detecting taking of screenshots.
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

/// Trigger used for detecting shake gestures.
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

/// Observer which can be subscribed to for getting shake gesture events.
class ShakeGestureObserver {

    public static let shared = ShakeGestureObserver()

    private var _subscribers = [ShakeGestureSubscriber]()

    private init() {}

    /// This method is used for subscribing to shake gesture events.
    public func subscribe(_ newSubsriber: ShakeGestureSubscriber) {
        _subscribers.append(newSubsriber)
    }

    /// Call this method in deinit after subscribing.
    public func unsubscribe(_ subscriber: ShakeGestureSubscriber) {
        _subscribers = _subscribers.filter({ $0 !== subscriber })
    }

    /// Method called when shake gesture is detected. It notifies all the subscribers for shake gesture events.
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
