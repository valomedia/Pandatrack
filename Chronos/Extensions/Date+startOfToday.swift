//
//  Date+startOfToday.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfToday

    static var startOfToday: Date {
        Calendar.current.startOfDay(for: Date())
    }

}
