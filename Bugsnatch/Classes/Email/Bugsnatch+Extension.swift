//
//  Bugsnatch+Extension.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 24/04/2019.
//

import Foundation

extension Bugsnatch {

    public func didTrigger() {
        guard let emailConfig = config?.triggerActionConfig as? EmailConfig else { return }
        EmailManager.shared.sendDebugEmail(with: emailConfig)
    }
}
