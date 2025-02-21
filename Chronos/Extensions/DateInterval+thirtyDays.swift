//
//  DateInterval+thirtyDays.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + thirtyDays

    static var thirtyDays: DateInterval {
        DateInterval(start: Calendar.current.date(byAdding: .day, value: -30, to: .tomorrow)!, end: .endOfToday)
    }

}
