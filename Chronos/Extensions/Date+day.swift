//
//  Date+day.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-11.
//
//

import Foundation


// MARK: Date

extension Date {

    // MARK: + day

    var day: Date {
        Calendar.current.startOfDay(for: self)
    }

}