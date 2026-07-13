//
//  Date+startOfNextYear.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfNextYear

    static var startOfNextYear: Date {
        Calendar.current.date(byAdding: .year, value: 1, to: Date.startOfThisYear)!
    }

}
