//
//  EmailConfig.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 17/05/2019.
//

import Foundation

/// Config used for configuring Email trigger action. It consists only of localization config.
public struct EmailConfig: TriggerActionConfig {

    var localization: EmailLocalizationConfig

    public init(localization: EmailLocalizationConfig = EmailLocalizationConfig()) {
        self.localization = localization
    }
}

/// Localization config for the Email trigger action.
/// This config can be modified when localizing text used in the Email trigger action.
public struct EmailLocalizationConfig {

    var mailServiceAlert: MailServiceAlertConfig

    public init(mailServiceAlert: MailServiceAlertConfig = MailServiceAlertConfig()) {
        self.mailServiceAlert = mailServiceAlert
    }

    public struct MailServiceAlertConfig {
        let title: String
        let description: String
        let ok: String

        public init(
            title: String = "Oops",
            description: String = "Mail services are not available. Please install the Mail app and link an account to it.",
            ok: String = "OK"
        ) {
            self.title = title
            self.description = description
            self.ok = ok
        }
    }
}
