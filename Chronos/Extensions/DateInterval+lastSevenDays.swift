//
//  DateInterval+lastSevenDays.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + lastSevenDays

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var lastSevenDays: DateInterval {
        DateInterval(start: Calendar.current.date(byAdding: .day, value: -7, to: .startOfToday)!, end: .endOfYesterday)
    }

}