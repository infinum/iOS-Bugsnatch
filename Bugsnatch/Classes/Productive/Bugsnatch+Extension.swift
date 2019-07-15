//
//  Bugsnatch+Extension.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 24/04/2019.
//

import Foundation

extension Bugsnatch: TriggerDelegate {

    public func didTrigger() {
        ProductiveViewController.present(with: config?.triggerActionConfig)
    }
}
