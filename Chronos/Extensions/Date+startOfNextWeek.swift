//
//  Date+startOfNextWeek.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfNextWeek

    static var startOfNextWeek: Date {
        Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date.startOfThisWeek)!
    }

}
