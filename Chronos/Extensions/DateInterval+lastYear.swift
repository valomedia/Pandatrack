//
//  DateInterval+lastYear.swift
//  Chronos
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + lastYear

    static var lastYear: DateInterval {
        DateInterval(start: .startOfLastYear, end: .endOfLastYear)
    }

}
