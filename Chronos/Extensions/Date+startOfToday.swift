//
//  Date+startOfToday.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfToday

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var startOfToday: Date {
        Calendar.current.startOfDay(for: Date())
    }

}