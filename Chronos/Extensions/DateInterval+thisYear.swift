//
//  DateInterval+thisYear.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + thisYear

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var thisYear: DateInterval {
        DateInterval(start: .startOfThisYear, end: .endOfThisYear)
    }

}