//
//  Bool+Extension.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 10/04/2019.
//

import Foundation

extension Bool {

    func mapTrue<T>(to object: T?) -> T? {
        return self ? object : nil
    }
}
