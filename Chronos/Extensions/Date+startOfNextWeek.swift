//
//  Date+startOfNextWeek.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfNextWeek

    static var startOfNextWeek: Date {
        Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date.startOfThisWeek)!
    }

}
