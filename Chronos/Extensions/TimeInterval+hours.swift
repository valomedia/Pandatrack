//
//  TimeInterval+hours.swift
//  Chronos
//

import Foundation


// MARK: TimeInterval

extension TimeInterval {

    // MARK: + hours

    var hours: Double {
        minutes / 60.0
    }
}