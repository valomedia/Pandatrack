//
//  Date+startOfLastMonth.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfLastMonth

    static var startOfLastMonth: Date {
        Calendar.current.date(byAdding: .month, value: -1, to: Date.startOfThisMonth)!
    }

}
