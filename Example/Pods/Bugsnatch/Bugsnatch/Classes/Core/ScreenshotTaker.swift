//
//  ScreenshotTaker.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 25/03/2019.
//

import UIKit

public class ScreenshotTaker {

    /// Takes a screenshot and saves it to the device.
    public static func saveScreenshot() {
        guard let screenshotImage = takeScreenshot() else { return }
        UIImageWriteToSavedPhotosAlbum(screenshotImage, nil, nil, nil)
    }

    /// Takes a screenshot of the screen.
    ///
    /// - Returns: Taken screenshot.
    public static func takeScreenshot() -> UIImage? {
        var screenshotImage: UIImage?
        guard let layer = UIApplication.shared.keyWindow?.layer else { return nil }
        let scale = UIScreen.main.scale

        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return screenshotImage
    }
}
