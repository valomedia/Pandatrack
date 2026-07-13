//
//  DateInterval+lastMonth.swift
//  Chronos
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + lastMonth

    static var lastMonth: DateInterval {
        DateInterval(start: .startOfLastMonth, end: .endOfLastMonth)
    }

}
