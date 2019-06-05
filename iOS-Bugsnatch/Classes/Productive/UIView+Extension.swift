//
//  UIView+Extension.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 16/05/2019.
//

import UIKit

extension UIView {

    var safeTopAnchor: NSLayoutYAxisAnchor? {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }
        return nil
    }

    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leftAnchor
        }
        return self.leftAnchor
    }

    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.rightAnchor
        }
        return self.rightAnchor
    }
}
