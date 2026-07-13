//
//  Date+endOfLastMonth.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfLastMonth

    static var endOfLastMonth: Date {
        .startOfThisMonth - 1
    }

}
