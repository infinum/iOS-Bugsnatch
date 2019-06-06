//
//  EmailManager.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 25/04/2019.
//

import MessageUI
import UIKit

public class EmailManager: NSObject {

    private override init() {}

    public static let shared = EmailManager()

    public func sendDebugEmail(with config: EmailConfig) {
        guard MFMailComposeViewController.canSendMail() else {
            _showMailServiceNotAvailableAlert(with: config)
            return
        }

        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self

        mailComposeVC.setSubject(Bugsnatch.shared.bugTitle)
        mailComposeVC.setMessageBody(Bugsnatch.shared.debugInfo, isHTML: false)

        guard
            let screenshotImage = ScreenshotTaker.takeScreenshot(),
            let screenshotImageData = screenshotImage.pngData(),
            let appNameWithoutSpaces = ApplicationInfo.appName?.components(separatedBy: .whitespaces).joined()
        else { return }

        mailComposeVC.addAttachmentData(screenshotImageData, mimeType: "image/png", fileName: "\(appNameWithoutSpaces).png")

        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.presentViewControllerFromVisibleViewController(viewControllerToPresent: mailComposeVC, animated: true)
    }

    // MARK: - Private methods -

    private func _showMailServiceNotAvailableAlert(with config: EmailConfig) {
        let alertController = UIAlertController(
            title: config.localization.mailServiceAlert.title,
            message: config.localization.mailServiceAlert.description,
            preferredStyle: .alert)

        let okAction = UIAlertAction(title: config.localization.mailServiceAlert.ok, style: .default)
        alertController.addAction(okAction)

        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.presentViewControllerFromVisibleViewController(viewControllerToPresent: alertController, animated: true)
    }
}

extension EmailManager: MFMailComposeViewControllerDelegate {

    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
