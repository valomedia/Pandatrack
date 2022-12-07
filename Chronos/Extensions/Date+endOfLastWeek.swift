//
//  Date+endOfLastWeek.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfLastWeek

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var endOfLastWeek: Date {
        .startOfThisWeek - 1
    }

}