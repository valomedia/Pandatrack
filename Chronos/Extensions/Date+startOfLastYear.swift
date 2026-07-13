//
//  Date+startOfLastYear.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfLastYear

    static var startOfLastYear: Date {
        Calendar.current.date(byAdding: .year, value: -1, to: Date.startOfThisYear)!
    }

}
