//
//  Date+subtractionOperator.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-11.
//
//

import Foundation


// MARK: Date

extension Date {

    // MARK: + subtractionOperator

    static func -(lhs: Date, rhs: Date) -> TimeInterval {
        DateInterval(start: rhs, end: lhs).duration
    }

}
