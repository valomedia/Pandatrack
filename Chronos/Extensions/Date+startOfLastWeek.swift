//
//  Date+startOfLastWeek.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfLastWeek

    static var startOfLastWeek: Date {
        Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date.startOfThisWeek)!
    }

}
