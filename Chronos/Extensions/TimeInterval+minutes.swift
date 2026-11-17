//
//  TimeInterval+minutes.swift
//  Chronos
//

import Foundation


// MARK: TimeInterval

extension TimeInterval {

    // MARK: + minutes

    var minutes: Double {
        self / 60.0
    }
}