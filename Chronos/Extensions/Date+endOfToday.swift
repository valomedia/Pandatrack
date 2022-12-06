//
//  Date+endOfToday.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfToday

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var endOfToday: Date {
        .startOfTomorrow - 1
    }

}