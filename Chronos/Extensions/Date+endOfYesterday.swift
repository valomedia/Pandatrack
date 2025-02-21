//
//  Date+endOfYesterday.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfYesterday

    static var endOfYesterday: Date {
        .startOfToday - 1
    }

}
