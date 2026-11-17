//
//  Date+startOfTomorrow.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfTomorrow

    static var startOfTomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: Date.startOfToday)!
    }

}
