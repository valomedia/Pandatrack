//
//  Date+endOfThisYear.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfThisYear

    static var endOfThisYear: Date {
        .startOfNextYear - 1
    }

}
