//
//  Date+endOfLastYear.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfLastYear

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var endOfLastYear: Date {
        .startOfThisYear - 1
    }

}