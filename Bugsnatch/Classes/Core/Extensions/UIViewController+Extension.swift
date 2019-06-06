//
//  UIViewController+Extension.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 25/04/2019.
//

import UIKit

extension UIViewController {

    // taken from https://gist.github.com/MartinMoizard/6537467
    public func presentViewControllerFromVisibleViewController(
        viewControllerToPresent: UIViewController,
        animated flag: Bool)
    {
        if let navigationController = self as? UINavigationController, let topViewController = navigationController.topViewController {
            topViewController.presentViewControllerFromVisibleViewController(
                viewControllerToPresent: viewControllerToPresent,
                animated: true)

        } else if let _presentedViewController = presentedViewController {
            _presentedViewController.presentViewControllerFromVisibleViewController(
                viewControllerToPresent: viewControllerToPresent,
                animated: true)

        } else {
            present(viewControllerToPresent, animated: true)
        }
    }
}
