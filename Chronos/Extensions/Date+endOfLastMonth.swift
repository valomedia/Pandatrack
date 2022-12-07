//
//  Date+endOfLastMonth.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfLastMonth

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var endOfLastMonth: Date {
        .startOfThisMonth - 1
    }

}