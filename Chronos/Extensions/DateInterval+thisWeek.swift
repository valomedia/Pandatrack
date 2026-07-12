//
//  DateInterval+thisWeek.swift
//  Chronos
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + thisWeek

    static var thisWeek: DateInterval {
        DateInterval(start: .startOfThisWeek, end: .endOfThisWeek)
    }

}
