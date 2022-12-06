//
//  Date+endOfThisWeek.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfThisWeek

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var endOfThisWeek: Date {
        .startOfNextWeek - 1
    }

}