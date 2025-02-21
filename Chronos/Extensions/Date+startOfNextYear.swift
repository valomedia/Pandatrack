//
//  Date+startOfNextYear.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + startOfNextYear

    static var startOfNextYear: Date {
        Calendar.current.date(byAdding: .year, value: 1, to: Date.startOfThisYear)!
    }

}
