//
//  DateInterval+lastWeek.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation


// MARK: DateInterval

extension DateInterval {

    // MARK: + lastWeek

    static var lastWeek: DateInterval {
        DateInterval(start: .startOfLastWeek, end: .endOfLastWeek)
    }

}
