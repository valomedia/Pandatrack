//
//  Date+startOfLastWeek.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfLastWeek

    static var startOfLastWeek: Date {
        Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date.startOfThisWeek)!
    }

}
