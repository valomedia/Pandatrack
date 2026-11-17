//
//  Date+endOfThisWeek.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfThisWeek

    static var endOfThisWeek: Date {
        .startOfNextWeek - 1
    }

}
