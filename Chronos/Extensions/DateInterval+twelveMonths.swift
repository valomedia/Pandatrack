//
//  DateInterval+twelveMonths.swift
//  Chronos
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + twelveMonths

    static var twelveMonths: DateInterval {
        DateInterval(
                start: Calendar.current.date(byAdding: .month, value: -12, to: .startOfNextMonth)!,
                end: .endOfThisMonth)
    }

}
