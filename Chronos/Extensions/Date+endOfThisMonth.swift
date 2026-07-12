//
//  Date+endOfThisMonth.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfThisMonth

    static var endOfThisMonth: Date {
        .startOfNextMonth - 1
    }

}
