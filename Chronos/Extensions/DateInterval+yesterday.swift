//
//  DateInterval+yesterday.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + yesterday

    static var yesterday: DateInterval {
        DateInterval(start: Date.startOfYesterday, end: Date.endOfYesterday)
    }

}
