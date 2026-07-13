//
//  DateInterval+today.swift
//  Chronos
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + today

    static var today: DateInterval {
        DateInterval(start: Date.startOfToday, end: Date.endOfToday)
    }

}
