//
//  Date+day.swift
//  Chronos
//

import Foundation


// MARK: Date

extension Date {

    // MARK: + day

    var day: Date {
        Calendar.current.startOfDay(for: self)
    }

}