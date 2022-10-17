//
//  Date+today.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + today

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var today: Date {
        Calendar.current.startOfDay(for: Date())
    }

}