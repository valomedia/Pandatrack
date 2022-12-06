//
//  Date+startOfTomorrow.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfTomorrow

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var startOfTomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: Date.startOfToday)!
    }

}
