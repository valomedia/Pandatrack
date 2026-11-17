//
//  Date+startOfYesterday.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfYesterday

    static var startOfYesterday: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: Date.startOfToday)!
    }

}
