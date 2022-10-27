//
//  Date+yesterday.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + yesterday

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var yesterday: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: Date.today) ?? Date.today - 24 * 60 * 60
    }

}