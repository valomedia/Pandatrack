//
//  Date+startOfThisYear.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfThisYear

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var startOfThisYear: Date {
        Calendar.current.dateComponents([.calendar, .year], from: Date()).date!
    }

}