//
//  DateInterval+lastYear.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + lastYear

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var lastYear: DateInterval {
        DateInterval(start: .startOfLastYear, end: .endOfLastYear)
    }

}