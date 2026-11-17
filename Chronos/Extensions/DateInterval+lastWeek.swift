//
//  DateInterval+lastWeek.swift
//  Chronos
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + lastWeek

    static var lastWeek: DateInterval {
        DateInterval(start: .startOfLastWeek, end: .endOfLastWeek)
    }

}
