//
//  Date+endOfToday.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation

// MARK: Date

extension Date {

    // MARK: + endOfToday

    static var endOfToday: Date {
        .startOfTomorrow - 1
    }

}
