//
//  Date+endOfLastWeek.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfLastWeek

    static var endOfLastWeek: Date {
        .startOfThisWeek - 1
    }

}
