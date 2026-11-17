//
//  DateInterval+thirtyDays.swift
//  Chronos
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + thirtyDays

    static var thirtyDays: DateInterval {
        DateInterval(start: Calendar.current.date(byAdding: .day, value: -30, to: .tomorrow)!, end: .endOfToday)
    }

}
