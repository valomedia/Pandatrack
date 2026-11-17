//
//  Date+startOfLastMonth.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfLastMonth

    static var startOfLastMonth: Date {
        Calendar.current.date(byAdding: .month, value: -1, to: Date.startOfThisMonth)!
    }

}
