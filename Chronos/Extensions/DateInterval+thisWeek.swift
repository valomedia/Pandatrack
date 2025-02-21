//
//  DateInterval+thisWeek.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + thisWeek

    static var thisWeek: DateInterval {
        DateInterval(start: .startOfThisWeek, end: .endOfThisWeek)
    }

}
