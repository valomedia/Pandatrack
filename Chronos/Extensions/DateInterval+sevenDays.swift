//
//  DateInterval+sevenDays.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + sevenDays

    static var sevenDays: DateInterval {
        DateInterval(start: Calendar.current.date(byAdding: .day, value: -7, to: .tomorrow)!, end: .endOfToday)
    }

}
