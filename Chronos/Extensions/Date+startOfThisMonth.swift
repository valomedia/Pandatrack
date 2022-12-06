//
//  Date+startOfThisMonth.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfThisMonth

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var startOfThisMonth: Date {
        Calendar.current.dateComponents([.calendar, .year, .month], from: Date()).date!
    }

}