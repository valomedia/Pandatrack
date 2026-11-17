//
//  Date+startOfThisWeek.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfThisWeek

    static var startOfThisWeek: Date {
        Calendar.current.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date()).date!
    }

}
