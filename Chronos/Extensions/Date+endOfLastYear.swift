//
//  Date+endOfLastYear.swift
//  Chronos
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfLastYear

    static var endOfLastYear: Date {
        .startOfThisYear - 1
    }

}
