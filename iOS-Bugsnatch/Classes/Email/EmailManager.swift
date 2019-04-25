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

    public func sendDebugEmail() {
        guard MFMailComposeViewController.canSendMail() else {
            print("Mail services are not available")
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
}

extension EmailManager: MFMailComposeViewControllerDelegate {

    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
