//
//  DateInterval+lastThirtyDays.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + lastThirtyDays

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var lastThirtyDays: DateInterval {
        DateInterval(start: Calendar.current.date(byAdding: .day, value: -30, to: .startOfToday)!, end: .endOfYesterday)
    }

}