//
//  Date+endOfThisMonth.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfThisMonth

    static var endOfThisMonth: Date {
        .startOfNextMonth - 1
    }

}
