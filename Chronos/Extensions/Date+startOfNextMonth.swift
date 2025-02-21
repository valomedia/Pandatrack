//
//  Date+startOfNextMonth.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfNextMonth

    static var startOfNextMonth: Date {
        Calendar.current.date(byAdding: .month, value: 1, to: Date.startOfThisMonth)!
    }

}
