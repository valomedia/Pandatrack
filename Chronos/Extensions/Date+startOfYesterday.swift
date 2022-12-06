//
//  Date+startOfYesterday.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfYesterday

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var startOfYesterday: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: Date.startOfToday)!
    }

}