//
//  DateInterval+thisYear.swift
//  Chronos
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + thisYear

    static var thisYear: DateInterval {
        DateInterval(start: .startOfThisYear, end: .endOfThisYear)
    }

}
