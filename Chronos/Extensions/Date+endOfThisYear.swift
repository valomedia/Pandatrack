//
//  Date+endOfThisYear.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfThisYear

    static var endOfThisYear: Date {
        .startOfNextYear - 1
    }

}
