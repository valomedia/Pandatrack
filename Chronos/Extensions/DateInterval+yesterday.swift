//
//  DateInterval+yesterday.swift
//  Chronos
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + yesterday

    static var yesterday: DateInterval {
        DateInterval(start: Date.startOfYesterday, end: Date.endOfYesterday)
    }

}
