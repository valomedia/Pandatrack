//
//  Date+startOfThisMonth.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfThisMonth

    static var startOfThisMonth: Date {
        Calendar.current.dateComponents([.calendar, .year, .month], from: Date()).date!
    }

}
