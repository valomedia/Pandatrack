//
//  Date+startOfThisYear.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfThisYear

    static var startOfThisYear: Date {
        Calendar.current.dateComponents([.calendar, .year], from: Date()).date!
    }

}
