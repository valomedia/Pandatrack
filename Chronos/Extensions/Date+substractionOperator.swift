//
//  Date+subtractionOperator.swift
//  Chronos
//

import Foundation


// MARK: Date

extension Date {

    // MARK: + subtractionOperator

    static func -(lhs: Date, rhs: Date) -> TimeInterval {
        DateInterval(start: rhs, end: lhs).duration
    }

}
