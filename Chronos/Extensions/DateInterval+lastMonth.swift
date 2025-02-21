//
//  DateInterval+lastMonth.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + lastMonth

    static var lastMonth: DateInterval {
        DateInterval(start: .startOfLastMonth, end: .endOfLastMonth)
    }

}
