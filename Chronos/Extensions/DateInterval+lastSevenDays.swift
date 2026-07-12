//
//  DateInterval+lastSevenDays.swift
//  Chronos
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + lastSevenDays

    static var lastSevenDays: DateInterval {
        DateInterval(start: Calendar.current.date(byAdding: .day, value: -7, to: .startOfToday)!, end: .endOfYesterday)
    }

}
