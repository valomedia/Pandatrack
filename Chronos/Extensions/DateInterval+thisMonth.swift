//
//  DateInterval+thisMonth.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + thisMonth

    static var thisMonth: DateInterval {
        DateInterval(start: .startOfThisMonth, end: .endOfThisMonth)
    }

}
