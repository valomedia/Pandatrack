//
//  Date+startOfThisWeek.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfThisWeek

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var startOfThisWeek: Date {
        Calendar.current.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date()).date!
    }

}