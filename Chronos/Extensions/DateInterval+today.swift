//
//  DateInterval+today.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + today

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var today: DateInterval {
        DateInterval(start: Date.startOfToday, end: Date.endOfToday)
    }

}