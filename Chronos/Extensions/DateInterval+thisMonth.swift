//
//  DateInterval+thisMonth.swift
//  Chronos
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + thisMonth

    static var thisMonth: DateInterval {
        DateInterval(start: .startOfThisMonth, end: .endOfThisMonth)
    }

}
