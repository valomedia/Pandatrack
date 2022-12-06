//
//  Date+startOfLastYear.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfLastYear

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var startOfLastYear: Date {
        Calendar.current.date(byAdding: .year, value: -1, to: Date.startOfThisYear)!
    }

}