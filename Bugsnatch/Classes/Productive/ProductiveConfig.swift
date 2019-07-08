//
//  ProductiveConfig.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 17/05/2019.
//

import Foundation

/// Config used for configuring Productive trigger action. If this config is not configured correctly, Productive trigger action will not work properly.
public struct ProductiveConfig: TriggerActionConfig {
    /// Productive organization id which can be found in the URL of the Productive tool in the browser. If you are having problems with finding it, contact Productive support.
    let organizationId: String
    /// Productive project id which can be found in the URL of the Productive tool in the browser. If you are having problems with finding it, contact Productive support.
    let projectId: Int
    let localization: ProductiveLocalizationConfig

    public init(organizationId: String, projectId: Int, localization: ProductiveLocalizationConfig = ProductiveLocalizationConfig()) {
        self.organizationId = organizationId
        self.projectId = projectId
        self.localization = localization
    }
}

/// Localization config for the Productive trigger action.
/// This config can be modified when localizing text used in the Productive trigger action.
public struct ProductiveLocalizationConfig {

    let closeButton: String
    let retryAlert: RetryAlertConfig
    let somethingWentWrongAlert: SomethingWentWrongAlertConfig

    public init(
        closeButton: String = "Close",
        retryAlert: RetryAlertConfig = RetryAlertConfig(),
        somethingWentWrongAlert: SomethingWentWrongAlertConfig = SomethingWentWrongAlertConfig()
    ) {
        self.closeButton = closeButton
        self.retryAlert = retryAlert
        self.somethingWentWrongAlert = somethingWentWrongAlert
    }

    public struct RetryAlertConfig {
        let title: String
        let description: String?
        let retry: String
        let cancel: String

        public init(
            title: String = "Oops",
            description: String? = nil,
            retry: String = "Retry",
            cancel: String = "Cancel"
        ) {
            self.title = title
            self.description = description
            self.retry = retry
            self.cancel = cancel
        }
    }

    public struct SomethingWentWrongAlertConfig {
        let title: String
        let description: String
        let ok: String

        public init(
            title: String = "Oops",
            description: String = "Something went wrong, please contact developers",
            ok: String = "OK"
        ) {
            self.title = title
            self.description = description
            self.ok = ok
        }
    }
}
