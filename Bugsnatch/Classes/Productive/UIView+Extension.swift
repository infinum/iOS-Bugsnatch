//
//  UIView+Extension.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 16/05/2019.
//

import UIKit

extension UIView {

    /// Returns `safeAreaLayoutGuide.topAnchor` if iOS 11.0 or above, else `nil`.
    var safeTopAnchor: NSLayoutYAxisAnchor? {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }
        return nil
    }

    /// Returns `safeAreaLayoutGuide.leftAnchor` if iOS 11.0 or above, else `leftAnchor`.
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leftAnchor
        }
        return self.leftAnchor
    }

    /// Returns `safeAreaLayoutGuide.rightAnchor` if iOS 11.0 or above, else `rightAnchor`.
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.rightAnchor
        }
        return self.rightAnchor
    }
}
