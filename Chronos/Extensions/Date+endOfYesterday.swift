//
//  Date+endOfYesterday.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfYesterday

    static var endOfYesterday: Date {
        .startOfToday - 1
    }

}
