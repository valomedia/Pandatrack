//
//  Date+endOfToday.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfToday

    static var endOfToday: Date {
        .startOfTomorrow - 1
    }

}
