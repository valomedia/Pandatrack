//
//  Date+startOfNextMonth.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfNextMonth

    static var startOfNextMonth: Date {
        Calendar.current.date(byAdding: .month, value: 1, to: Date.startOfThisMonth)!
    }

}
