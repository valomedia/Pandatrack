//
//  DateInterval+lastThirtyDays.swift
//  Chronos
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + lastThirtyDays

    static var lastThirtyDays: DateInterval {
        DateInterval(start: Calendar.current.date(byAdding: .day, value: -30, to: .startOfToday)!, end: .endOfYesterday)
    }

}
